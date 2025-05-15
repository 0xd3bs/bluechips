#[derive(Copy, Drop)]
pub struct Tree {
    pub base_weights: Span<i32>,
    pub left_children: Span<u32>,
    pub right_children: Span<u32>,
    pub split_indices: Span<u32>,
    pub split_conditions: Span<i32>,
}

/// Navigates a decision tree and accumulates the score for a given set of features.
///
/// # Parameters
/// - `tree`: The decision tree to navigate, represented as a `Tree` struct.
/// - `features`: A span of feature values used for decision-making at each node.
/// - `node`: The current node index in the tree.
///
/// # Returns
/// The accumulated score as an integer.
pub fn navigate_tree_and_accumulate_score(tree: Tree, features: Span<i32>, node: u32) -> i32 {
    if *tree.left_children.at(node) == 0 {
        if *tree.right_children.at(node) == 0 {
            return *tree.base_weights.at(node);
        }
    }

    let mut next_node: u32 = 0;
    let feature_index = *tree.split_indices.at(node);
    let threshold = *tree.split_conditions.at(node);
    if *features.at(feature_index) < threshold {
        next_node = *tree.left_children.at(node);
    } else {
        next_node = *tree.right_children.at(node);
    }

    navigate_tree_and_accumulate_score(tree, features, next_node)
}

/// Accumulates scores from multiple decision trees for a given set of features.
///
/// # Parameters
/// - `num_trees`: The total number of trees in the model.
/// - `trees`: A span of decision trees, each represented as a `Tree` struct.
/// - `features`: A span of feature values used for decision-making.
/// - `index`: The current tree index being processed.
/// - `accumulated_score`: The score accumulated so far.
///
/// # Returns
/// The total accumulated score as an integer.
pub fn accumulate_scores_from_trees(
    num_trees: u32, trees: Span<Tree>, features: Span<i32>, index: u32, accumulated_score: i32,
) -> i32 {
    if index >= num_trees {
        return accumulated_score;
    }
    let tree: Tree = *trees.at(index);
    let score_from_tree: i32 = navigate_tree_and_accumulate_score(tree, features, 0);
    accumulate_scores_from_trees(
        num_trees, trees, features, index + 1, accumulated_score + score_from_tree,
    )
}

