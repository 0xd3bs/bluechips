from flask import Blueprint
from utils import standard_response
from model_runner import run_model
from data_fetcher import get_data

api_v1 = Blueprint("api_v1", __name__, url_prefix="/api/v1")


@api_v1.route("/")
def home():
    return standard_response(success=True, data={"status": "healthy"})


@api_v1.route("/predictions/<asset>")
def predict_asset(asset):
    """
    Predicts the BTC asset using the compiled Cairo model.

    Returns:
        JSON: A standardized JSON response with BTC prediction.
            - 1: Anticipates a Bull market for the next session.
            - 2: Anticipates a Bear market for the next session.
            - 3: Indicates an error occurred during the execution of the model.
    """
    allowed_assets = ["BTC", "ETH"]
    asset_upper = asset.upper()
    if asset_upper not in allowed_assets:
        return standard_response(
            success=False, error=f"Asset {asset_upper} not supported."
        )
    try:
        model_name = f"model_{asset.lower()}"
        prediction = run_model(model_name)
        return standard_response(
            success=True, data={"asset": asset_upper, "prediction": prediction}
        )
    except Exception as e:
        return standard_response(success=False, error=str(e))


@api_v1.route("/predictions/all")
def predict_all():
    """
    Predicts both BTC and ETH assets using the compiled Cairo models.

    Returns:
        JSON: A standardized JSON response with predictions for both BTC and ETH assets.
        Even if one prediction fails, it will return partial results with the successful ones.
    """
    try:
        predictions = []
        success_expected = True
        for asset in ["BTC", "ETH"]:
            model_name = f"model_{asset.lower()}"
            try:
                prediction = run_model(model_name)
                predictions.append(
                    {"asset": asset, "prediction": prediction, "success": True}
                )
            except Exception as e:
                success_expected = False
                predictions.append(
                    {
                        "asset": asset,
                        "prediction": None,
                        "success": False,
                        "error": str(e),
                    }
                )
        return standard_response(
            success=success_expected, data={"predictions": predictions}
        )
    except Exception as e:
        return standard_response(success=False, error=str(e))


@api_v1.route("/predictions/<asset>/features")
def get_features(asset):
    """
    Retrieves historical OHLCV price data for a given cryptocurrency ticker from Binance and computes lagged return features.

    Parameters:
    -----------
    - `ticker` (str): The symbol of the asset (e.g., 'BTC', 'ETH').

    Returns:
    --------
    - `json`:
    A JSON object containing lagged return values, structured as:
    { features: { return_lag_1: value, return_lag_2: value, return_lag_3: value }, success: true | false }
    """
    allowed_assets = ["BTC", "ETH"]
    if asset.upper() not in allowed_assets:
        return standard_response(success=False, error=f"Asset {asset} not supported.")
    try:
        return_lag_1, return_lag_2, return_lag_3, is_first_parameter_negative = (
            get_data(asset.upper())
        )
        features = {
            "return_lag_1": return_lag_1,
            "return_lag_2": return_lag_2,
            "return_lag_3": return_lag_3,
            "is_first_parameter_negative": is_first_parameter_negative,
        }
        return standard_response(success=True, data={"features": features})
    except Exception as e:
        return standard_response(success=False, error=str(e))
