from pathlib import Path
import shutil
import json
from datetime import datetime
import subprocess


class LocalTranspiler:
    def __init__(self, output_dir="cairo"):
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(parents=True, exist_ok=True)

    def xgboost_json_to_cairo(self, model_json: dict, output_name: str) -> str:
        """Convierte un modelo XGBoost en formato JSON a código Cairo"""
        # Create the directory for the model
        model_output_dir = self.output_dir / output_name
        if model_output_dir.exists():
            shutil.rmtree(model_output_dir)
        model_output_dir.mkdir(parents=True)
        src_dir = model_output_dir / "src"
        src_dir.mkdir(exist_ok=True)

        # Generate Cairo code
        self._generate_model_files(model_json, src_dir)
        self._generate_scarb_toml(model_output_dir)

        # Generate .gitignore
        self._generate_gitignore(model_output_dir)

        # Format files with Scarb
        subprocess.run(["scarb", "fmt"], cwd=model_output_dir)

        return str(model_output_dir)

    def _generate_model_files(self, model_data: dict, src_dir: Path):
        """Genera los archivos Cairo del modelo"""
        # Generate the lib.cairo file with the model data
        self._generate_lib_cairo(model_data, src_dir)
        # Generate the xgb_inference.cairo file
        self._generate_xgb_inference_cairo(src_dir)

    def _generate_lib_cairo(self, model_data: dict, src_dir: Path):
        """Genera el archivo lib.cairo con los datos del modelo"""
        trees_data = model_data["learner"]["gradient_booster"]["model"]
        n_trees = int(trees_data["gbtree_model_param"]["num_trees"])
        base_score = self._decimal_to_fixed_point(
            float(model_data["learner"]["learner_model_param"]["base_score"])
        )

        with open(src_dir / "lib.cairo", "w") as f:
            f.write("mod xgb_inference;\n\n")
            f.write("fn predict(input_vector: Span<i32>) -> i32 {\n")

            # Generar cada árbol
            for i in range(n_trees):
                tree = (
                    trees_data["trees"][i]
                    if "trees" in trees_data
                    else trees_data["tree_info"][i]
                )

                base_weights = self._get_tree_values(
                    tree, "base_weights", "leaf_values"
                )
                left_children = self._get_tree_values(tree, "left_children")
                right_children = self._get_tree_values(tree, "right_children")
                split_indices = self._get_tree_values(
                    tree, "split_indices", "split_features"
                )
                split_conditions = self._get_tree_values(tree, "split_conditions")

                f.write(
                    f"""    let tree_{i} = xgb_inference::Tree {{
    base_weights: array![{', '.join(str(w) for w in base_weights)}].span(),
    left_children: array![{', '.join(str(c) for c in left_children)}].span(),
    right_children: array![{', '.join(str(c) for c in right_children)}].span(),
    split_indices: array![{', '.join(str(idx) for idx in split_indices)}].span(),
    split_conditions: array![{', '.join(str(cond) for cond in split_conditions)}].span()
}};\n"""
                )

            # Generar código para procesar los árboles
            f.write(
                f"""    let num_trees: u32 = {n_trees};
    let base_score: i32 = {base_score};
    let opt_type: u8 = 0;
    let trees: Span<xgb_inference::Tree> = array![{', '.join(f'tree_{i}' for i in range(n_trees))}].span();
    let mut result: i32 = xgb_inference::accumulate_scores_from_trees(num_trees, trees, input_vector, 0, 0);

    if opt_type == 1 {{
        // Implement logic here
    }} else {{
        result = result + base_score;
    }}

    return result;
}}
"""
            )
            f.write(
                """
#[executable]                    
fn main(return_lag_1:i32, return_lag_2:i32, return_lag_3:i32, is_first_parameter_negative:u8) -> i32 {
    let mut input_vector = ArrayTrait::new();
                    
    let return_lag_1_check = if is_first_parameter_negative == 1 {
        -return_lag_1
    } else {
        return_lag_1
    };

    input_vector.append(return_lag_1_check);
    input_vector.append(return_lag_2);
    input_vector.append(return_lag_3);
    let result = predict(input_vector.span());
    println!("Inference result: {}", result);
    let predict = if result > 0 {
        1
    } else {
        2
    };
    predict
}
"""
            )

            # Restore the writing of the main function
            # Add unit test module dynamically based on the model
            model_name = src_dir.parent.name
            if model_name == "model_btc":
                f.write(
                    """#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let mut input_vector = ArrayTrait::new();
        input_vector.append(46896864);
        input_vector.append(19840426);
        input_vector.append(-48111976);
        let result = predict(input_vector.span());
        println!("Inference result: {}", result);
        assert(result == 15654362, 'BTC model works!');
    }
}
"""
                )
            elif model_name == "model_eth":
                f.write(
                    """#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let mut input_vector = ArrayTrait::new();
        input_vector.append(87314475);
        input_vector.append(36283875);
        input_vector.append(-60821064);
        let result = predict(input_vector.span());
        println!("Inference result: {}", result);
        assert(result == 36900855, 'ETH model works!');
    }
}
"""
                )

    def _generate_xgb_inference_cairo(self, src_dir: Path):
        """Genera el archivo xgb_inference.cairo"""
        with open(src_dir / "xgb_inference.cairo", "w") as f:
            f.write("#[derive(Copy, Drop)]\n")
            f.write("pub struct Tree {\n")
            f.write("    pub base_weights: Span<i32>,\n")
            f.write("    pub left_children: Span<u32>,\n")
            f.write("    pub right_children: Span<u32>,\n")
            f.write("    pub split_indices: Span<u32>,\n")
            f.write("    pub split_conditions: Span<i32>\n")
            f.write("}\n\n")

            f.write(
                "/// Navigates a decision tree and accumulates the score for a given set of features.\n"
            )
            f.write("/// \n")
            f.write("/// # Parameters\n")
            f.write(
                "/// - `tree`: The decision tree to navigate, represented as a `Tree` struct.\n"
            )
            f.write(
                "/// - `features`: A span of feature values used for decision-making at each node.\n"
            )
            f.write("/// - `node`: The current node index in the tree.\n")
            f.write("/// \n")
            f.write("/// # Returns\n")
            f.write("/// The accumulated score as an integer.\n")
            f.write(
                "pub fn navigate_tree_and_accumulate_score(tree: Tree, features: Span<i32>, node: u32) -> i32 {\n"
            )
            f.write("    if *tree.left_children.at(node) == 0 {\n")
            f.write("        if *tree.right_children.at(node) == 0 {\n")
            f.write("            return *tree.base_weights.at(node);\n")
            f.write("        }\n")
            f.write("    }\n\n")
            f.write("    let mut next_node : u32  = 0;\n")
            f.write("    let feature_index = *tree.split_indices.at(node);\n")
            f.write("    let threshold = *tree.split_conditions.at(node);\n")
            f.write("    if *features.at(feature_index) < threshold{\n")
            f.write("        next_node  = *tree.left_children.at(node);\n")
            f.write("    }\n")
            f.write("    else{\n")
            f.write("        next_node  = *tree.right_children.at(node);\n")
            f.write("    }\n\n")
            f.write(
                "    navigate_tree_and_accumulate_score(tree, features, next_node)\n"
            )
            f.write("}\n\n")

            f.write(
                "/// Accumulates scores from multiple decision trees for a given set of features.\n"
            )
            f.write("/// \n")
            f.write("/// # Parameters\n")
            f.write("/// - `num_trees`: The total number of trees in the model.\n")
            f.write(
                "/// - `trees`: A span of decision trees, each represented as a `Tree` struct.\n"
            )
            f.write(
                "/// - `features`: A span of feature values used for decision-making.\n"
            )
            f.write("/// - `index`: The current tree index being processed.\n")
            f.write("/// - `accumulated_score`: The score accumulated so far.\n")
            f.write("/// \n")
            f.write("/// # Returns\n")
            f.write("/// The total accumulated score as an integer.\n")
            f.write(
                "pub fn accumulate_scores_from_trees(num_trees: u32, trees: Span<Tree>, features: Span<i32>, index:u32, accumulated_score:i32) -> i32{\n"
            )
            f.write("    if index >= num_trees{\n")
            f.write("        return accumulated_score;\n")
            f.write("        }\n")
            f.write("    let tree: Tree = *trees.at(index);\n")
            f.write(
                "    let score_from_tree: i32 = navigate_tree_and_accumulate_score(tree, features, 0);\n"
            )
            f.write(
                "    accumulate_scores_from_trees(num_trees, trees, features, index + 1, accumulated_score + score_from_tree)\n"
            )
            f.write("}\n\n")

    def _decimal_to_fixed_point(self, num: float, precision: int = 32) -> int:
        """Convierte un número decimal a formato fixed-point con precisión configurable"""
        # Convert a decimal number to fixed-point format with configurable precision
        return int(
            round(num * (1 << precision))
        )  # Multiplicar por 2^precision para convertir a fixed-point

    def _get_tree_values(
        self, tree: dict, primary_key: str, fallback_key: str = None
    ) -> list:
        """Extrae valores del árbol con manejo de claves alternativas y conversión"""
        # Extract values from the tree with alternative key handling and conversion
        if primary_key in tree:
            values = tree[primary_key]
        elif fallback_key and fallback_key in tree:
            values = tree[fallback_key]
        else:
            raise KeyError(
                f"No se encontró {primary_key} ni {fallback_key} en el árbol"
            )

        # Convertir valores según el tipo
        if primary_key in ["base_weights", "split_conditions"]:
            return [
                (
                    self._decimal_to_fixed_point(float(v))
                    if self._decimal_to_fixed_point(float(v)) != 0
                    else "0"
                )
                for v in values
            ]
        else:
            # Reemplazar -1 por 0 en left_children y right_children
            if primary_key in ["left_children", "right_children"]:
                values = [0 if v == -1 else v for v in values]
            return [int(v) for v in values]

    def _generate_scarb_toml(self, output_dir: Path):
        """Genera el archivo Scarb.toml"""
        # Obtener el nombre del modelo del directorio de salida
        model_name = output_dir.name.lower()

        content = f"""[package]
name = "{model_name}"
version = "0.1.0"
edition = "2024_07"

[[target.executable]]

[cairo]
enable-gas = false

[dependencies]
cairo_execute = "2.11.4"

[dev-dependencies]
cairo_test = "2.11.4"
"""
        with open(output_dir / "Scarb.toml", "w") as f:
            f.write(content)

    def _generate_gitignore(self, output_dir: Path):
        """Genera el archivo .gitignore"""
        # Generate the .gitignore file
        with open(output_dir / ".gitignore", "w") as f:
            f.write("# Exclude execution directories\n")
            f.write("target/\n")


def transpile_model(model_json, output_name):
    transpiler = LocalTranspiler(output_dir="cairo")
    return transpiler.xgboost_json_to_cairo(model_json, output_name)
