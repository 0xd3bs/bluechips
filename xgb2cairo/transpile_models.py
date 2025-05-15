import json
import shutil
from pathlib import Path
from local_transpiler import LocalTranspiler


def main():
    print("Iniciando transpilación de modelos...")

    # Limpiar directorio cairo si existe
    output_dir = Path("cairo")
    if output_dir.exists():
        print("Limpiando directorio cairo anterior...")
        shutil.rmtree(output_dir)

    # Inicializar transpilador
    transpiler = LocalTranspiler(output_dir="cairo")

    # Transpile the BTC model
    print("\nProcessing BTC model...")
    with open("trained_models/model_btc.json") as f:
        model_json = json.load(f)
    btc_output = transpiler.xgboost_json_to_cairo(model_json, "model_btc")

    # Transpile the ETH model
    print("\nProcessing ETH model...")
    with open("trained_models/model_eth.json") as f:
        model_json = json.load(f)
    eth_output = transpiler.xgboost_json_to_cairo(model_json, "model_eth")

    print("\n" + "=" * 50)
    print("Transpilación completada. Archivos generados:")
    print(f"- {Path(btc_output).absolute()}/")
    print(f"- {Path(eth_output).absolute()}/")
    print("=" * 50)


if __name__ == "__main__":
    main()
