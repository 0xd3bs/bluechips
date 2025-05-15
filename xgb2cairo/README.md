# XGBoost to Cairo

This project allows converting trained XGBoost models to executable Cairo code, specifically designed for BTC and ETH price prediction models.

Additionally, the trained model, once transpiled to Cairo, is used by the BlueChipAI API to generate verifiable predictions through its representation in Zero-Knowledge Machine Learning (ZKML).

## Compatible Versions

This project has been tested with:
- Python 3.11.5
- XGBoost 2.1.3
- Cairo 2.11.4
- Scarb 2.11.4

## Requirements

First, create and activate a virtual environment, then install the dependencies:

```bash
# Create and activate virtual environment
python -m venv venv
source venv/bin/activate  # On Windows use: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```
Or
```bash
python -m venv venv && source venv/bin/activate && pip install -r requirements.txt
```

## Workflow

### 1. Transpilation to Cairo
```bash
python transpile_models.py
```
Converts XGBoost models to Cairo code:
- Replaces all occurrences of `-1` in the `left_children` and `right_children` fields with `0` for compatibility with Cairo execution.
- Uses a Fixed Point 32x32 representation for numerical values in the Cairo implementation.
- Generates Cairo implementation for each tree.
- Creates Scarb project structure.
- Generated files in `cairo/model_btc/` and `cairo/model_eth/`.

### 2. Model Validation
```bash
# Run Python tests
python test_python_models.py
```

## Generated Files

Generated files are located in the `cairo/` directory:
- `model_btc/` and `model_eth/`: Cairo implementations of the models

Run Cairo tests
```bash
scarb test
```
Run Cairo exec
```bash
scarb execute --print-program-output --arguments 46896864,19840426,-48111976,2
```

## Important Notes

- The `cairo/` directory is automatically cleaned on each execution