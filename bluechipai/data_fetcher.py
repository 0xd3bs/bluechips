import pandas as pd
import ccxt
import os

DEBUG = os.getenv("DEBUG", "false").lower() == "true"


def get_data(ticker):
    """
    Retrieves historical OHLCV price data for a given cryptocurrency ticker from Binance and computes lagged return features.

    Parameters:
    -----------
    - `ticker` (str): The symbol of the asset (e.g., 'BTC', 'ETH').

    Returns:
    --------
    - `pd.DataFrame`:
      A DataFrame containing lagged return columns (`return_lag_1`, `return_lag_2`, `return_lag_3`) for the most recent available days.
    """
    exchange = ccxt.kraken()
    symbol = f"{ticker}/USDT"
    timeframe = "1d"
    lags = [1, 2, 3]
    end_date = pd.Timestamp.today().normalize()
    start_date = end_date - pd.Timedelta(days=4)
    since = exchange.parse8601(f'{start_date.strftime("%Y-%m-%d")}T00:00:00Z')

    try:
        ohlcv = exchange.fetch_ohlcv(symbol, timeframe, since)
        if not ohlcv:
            raise ValueError(f"No data returned from the exchange for ticker: {ticker}")

        df = pd.DataFrame(
            ohlcv, columns=["timestamp", "open", "high", "low", "close", "volume"]
        )
        df["timestamp"] = pd.to_datetime(df["timestamp"], unit="ms")
        df.set_index("timestamp", inplace=True)
        df = df[df.index <= end_date]
        df["close"] = df["close"].pct_change()

        for lag in lags:
            df[f"return_lag_{lag}"] = df["close"].shift(lag)

        lag_cols = [col for col in df.columns if "lag" in col]
        result = df[lag_cols].dropna()

        if result.empty:
            raise ValueError(f"Insufficient data for ticker: {ticker}")

        return_lag_1, return_lag_2, return_lag_3 = result.iloc[-1]

        if DEBUG:
            print(
                f"{ticker} Lagged returns: {return_lag_1}, {return_lag_2}, {return_lag_3}"
            )

        def to_fixed_point(value):
            return int(value * (1 << 32))

        return_lag_1 = to_fixed_point(return_lag_1)
        return_lag_2 = to_fixed_point(return_lag_2)
        return_lag_3 = to_fixed_point(return_lag_3)

        is_first_parameter_negative = 1 if return_lag_1 < 0 else 2
        return_lag_1 = (
            abs(return_lag_1) if is_first_parameter_negative == 1 else return_lag_1
        )

        return return_lag_1, return_lag_2, return_lag_3, is_first_parameter_negative

    except ccxt.BaseError as e:
        error_msg = f"Error fetching data for {ticker}: {e}"
        if DEBUG:
            print(error_msg)
        raise
