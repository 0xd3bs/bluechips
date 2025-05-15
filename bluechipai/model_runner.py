import os
import subprocess
from data_fetcher import get_data

DEBUG = os.getenv("DEBUG", "false").lower() == "true"


def run_model(model_name: str) -> int:
    """
    Executes a compiled Cairo model and returns the prediction as an integer.

    Parameters:
    -----------
    - `model_name` (str): The name of the model to execute. Expected values are 'model_btc' or 'model_eth'.

    Returns:
    --------
    - `int`: The inference result, typically 1 or 2.

    Raises:
    -------
    - `ValueError`: If data retrieval fails or if no valid prediction is found.
    - `subprocess.CalledProcessError`: If the subprocess execution fails.
    - `Exception`: For any other errors.
    """
    base_dir = os.path.dirname(__file__)
    cairo_root = os.path.join(base_dir, "cairo", model_name)
    ticker = model_name.split("model_")[1].upper()

    try:
        return_lag_1, return_lag_2, return_lag_3, is_first_parameter_negative = (
            get_data(ticker)
        )

        if DEBUG:
            print(
                f"Running model {model_name} with inputs: {return_lag_1}, {return_lag_2}, {return_lag_3}"
            )

        command = [
            "scarb",
            "execute",
            "-p",
            model_name,
            "--print-program-output",
            "--no-build",
            "--arguments",
            f"{return_lag_1},{return_lag_2},{return_lag_3},{is_first_parameter_negative}",
        ]

        result = subprocess.run(
            command, capture_output=True, text=True, check=True, cwd=cairo_root
        )
        output_lines = result.stdout.strip().splitlines()

        for line in output_lines:
            if line.strip().isdigit():
                return int(line.strip())

        raise ValueError(f"No valid prediction found in model output for {ticker}")

    except subprocess.CalledProcessError as e:
        if DEBUG:
            print(f"Subprocess error: {e}")
        raise
