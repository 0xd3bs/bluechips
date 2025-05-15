import unittest
import pandas as pd
import numpy as np
import json
from xgboost import XGBRegressor

# Functions from model_test.py


def create_features(df, target, lags=[1, 2, 3]):
    df = df.copy()
    df["target"] = df[target].pct_change()
    for lag in lags:
        df[f"return_lag_{lag}"] = df["target"].shift(lag)
    return df.dropna()


def hacer_prediccion(modelo, datos_nuevos):
    print(f"Parámetros (hacer_prediccion): {datos_nuevos.values}\n")
    prediccion = modelo.predict(datos_nuevos)
    return prediccion


class TestModelPredictions(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        """Prepare the data and the models for testing"""
        # BTC test data
        cls.test_df_btc = pd.DataFrame(
            {
                "timestamp": pd.date_range(
                    start="2025-03-30", end="2025-04-18", freq="D"
                ),
                "open": [
                    82648.53,
                    82390.0,
                    82550.0,
                    85158.35,
                    82516.28,
                    83213.09,
                    83889.87,
                    83537.99,
                    78430.0,
                    79163.24,
                    76322.42,
                    82615.22,
                    79607.3,
                    83423.83,
                    85276.91,
                    83760.0,
                    84591.58,
                    83643.99,
                    84030.38,
                    84947.92,
                ],
                "close": [
                    82389.99,
                    82550.01,
                    85158.34,
                    82516.29,
                    83213.09,
                    83889.87,
                    83537.99,
                    78430.0,
                    79163.24,
                    76322.42,
                    82615.22,
                    79607.3,
                    83423.84,
                    85276.9,
                    83760.0,
                    84591.58,
                    83643.99,
                    84030.38,
                    84947.91,
                    84496.2,
                ],
                "high": [
                    83534.64,
                    83943.08,
                    85579.46,
                    88500.0,
                    83998.02,
                    84720.0,
                    84266.0,
                    83817.63,
                    81243.58,
                    80867.99,
                    83588.0,
                    82753.21,
                    84300.0,
                    85905.0,
                    86100.0,
                    85799.99,
                    86496.42,
                    85500.0,
                    85470.01,
                    85132.08,
                ],
                "low": [
                    81565.0,
                    81278.52,
                    82432.74,
                    82320.0,
                    81211.24,
                    81659.0,
                    82379.95,
                    77153.83,
                    74508.0,
                    76239.9,
                    74620.0,
                    78464.36,
                    78969.58,
                    82792.95,
                    83034.23,
                    83678.0,
                    83600.0,
                    83111.64,
                    83736.26,
                    84303.96,
                ],
                "volume": [
                    9864.49508,
                    20569.13885,
                    20190.39697,
                    39931.457,
                    27337.84135,
                    32915.53976,
                    9360.40468,
                    27942.71436,
                    78387.53089,
                    35317.32063,
                    75488.28772,
                    33284.80718,
                    34435.43797,
                    18470.74437,
                    24680.04181,
                    28659.09348,
                    20910.99528,
                    20867.24519,
                    13728.84772,
                    5937.96317,
                ],
            }
        )

        cls.test_df_eth = pd.DataFrame(
            {
                "timestamp": pd.date_range(
                    start="2025-03-30", end="2025-04-18", freq="D"
                ),
                "open": [
                    1580.77,
                    1553.04,
                    1473.41,
                    1669.51,
                    1522.24,
                    1566.85,
                    1644.19,
                    1597.76,
                    1623.78,
                    1588.77,
                    1577.15,
                    1583.63,
                    1588.6,
                    1613.26,
                    1587.36,
                    1579.57,
                    1756.25,
                    1795.08,
                    1769.64,
                    1784.6,
                ],
                "close": [
                    1553.04,
                    1473.41,
                    1669.51,
                    1522.25,
                    1566.85,
                    1644.18,
                    1597.76,
                    1623.77,
                    1588.78,
                    1577.14,
                    1583.62,
                    1588.6,
                    1613.27,
                    1587.36,
                    1579.57,
                    1756.26,
                    1795.07,
                    1769.65,
                    1784.6,
                    1809.12,
                ],
                "high": [
                    1639.0,
                    1618.67,
                    1689.0,
                    1669.85,
                    1591.47,
                    1669.59,
                    1649.75,
                    1691.5,
                    1661.21,
                    1613.66,
                    1616.96,
                    1600.64,
                    1631.81,
                    1619.19,
                    1658.75,
                    1778.0,
                    1834.86,
                    1802.82,
                    1827.32,
                    1815.81,
                ],
                "low": [
                    1411.01,
                    1441.3,
                    1385.05,
                    1471.02,
                    1504.63,
                    1546.06,
                    1562.01,
                    1595.56,
                    1583.12,
                    1538.07,
                    1563.2,
                    1573.54,
                    1585.01,
                    1565.59,
                    1564.07,
                    1537.26,
                    1744.95,
                    1722.9,
                    1738.6,
                    1784.6,
                ],
                "volume": [
                    2168796.0067,
                    891846.1327,
                    1968530.9138,
                    911855.3934,
                    578484.3183,
                    501867.9033,
                    580136.6145,
                    645930.1419,
                    476178.8915,
                    611387.8686,
                    449870.3628,
                    200409.0359,
                    223096.3899,
                    276052.2306,
                    691486.6667,
                    1103036.9586,
                    887545.6316,
                    483465.0385,
                    595610.8894,
                    61147.8009,
                ],
            }
        )
        # Load BTC model
        cls.model_btc = XGBRegressor()
        try:
            cls.model_btc.load_model("trained_models/model_btc.json")
        except Exception as e:
            print(f"Error loading the BTC model: {e}")
            raise
        # Load ETH model
        cls.model_eth = XGBRegressor()
        try:
            cls.model_eth.load_model("trained_models/model_eth.json")
        except Exception as e:
            print(f"Error loading the ETH model: {e}")
            raise

    def test_create_features(self):
        """Test the create_features function"""
        # Prepare data
        df = self.test_df_btc.copy()
        df.index = df["timestamp"]
        df.drop(columns="timestamp", inplace=True)

        # Execute function
        result = create_features(df.reset_index(), "close")

        # Assertions
        self.assertIsInstance(result, pd.DataFrame)
        self.assertTrue("target" in result.columns)
        self.assertTrue("return_lag_1" in result.columns)
        self.assertTrue("return_lag_2" in result.columns)
        self.assertTrue("return_lag_3" in result.columns)

    def test_model_predictions_btc(self):
        """Test the BTC model predictions"""
        df = self.test_df_btc.copy()
        df.index = df["timestamp"]
        df.drop(columns="timestamp", inplace=True)
        data = create_features(df.reset_index(), "close")
        data = data.set_index("timestamp")
        X = data.drop(columns=["target", "open", "high", "low", "close", "volume"])
        print("BTC X:")
        print(X)
        predictions = self.model_btc.predict(X)
        print(f"BTC predictions: {predictions}")
        self.assertIsInstance(predictions, np.ndarray)
        self.assertEqual(len(predictions), len(X))
        self.assertTrue(all(~np.isnan(predictions)))

    def test_model_predictions_eth(self):
        """Test the ETH model predictions"""
        df = self.test_df_eth.copy()
        df.index = df["timestamp"]
        df.drop(columns="timestamp", inplace=True)
        data = create_features(df.reset_index(), "close")
        data = data.set_index("timestamp")
        X = data.drop(columns=["target", "open", "high", "low", "close", "volume"])
        print("ETH X:")
        print(X)
        predictions = self.model_eth.predict(X)
        print(f"ETH predictions: {predictions}")
        self.assertIsInstance(predictions, np.ndarray)
        self.assertEqual(len(predictions), len(X))
        self.assertTrue(all(~np.isnan(predictions)))

    def test_hacer_prediccion_btc(self):
        """Test the hacer_prediccion function for BTC"""
        df = self.test_df_btc.copy()
        df.index = df["timestamp"]
        df.drop(columns="timestamp", inplace=True)
        data = create_features(df.reset_index(), "close")
        data = data.set_index("timestamp")
        X = data.drop(columns=["target", "open", "high", "low", "close", "volume"])
        print("BTC X:")
        print(X)
        prediccion = hacer_prediccion(self.model_btc, X)
        print(f"BTC hacer_prediccion: {prediccion}")
        self.assertIsInstance(prediccion, np.ndarray)
        self.assertEqual(len(prediccion), len(X))
        self.assertTrue(all(~np.isnan(prediccion)))

    def test_hacer_prediccion_eth(self):
        """Test the hacer_prediccion function for ETH"""
        df = self.test_df_eth.copy()
        df.index = df["timestamp"]
        df.drop(columns="timestamp", inplace=True)
        data = create_features(df.reset_index(), "close")
        data = data.set_index("timestamp")
        X = data.drop(columns=["target", "open", "high", "low", "close", "volume"])
        print("ETH X:")
        print(X)
        prediccion = hacer_prediccion(self.model_eth, X)
        print(f"ETH hacer_prediccion: {prediccion}")
        self.assertIsInstance(prediccion, np.ndarray)
        self.assertEqual(len(prediccion), len(X))
        self.assertTrue(all(~np.isnan(prediccion)))

    def test_input_validation(self):
        """Test handling of invalid inputs"""
        # Test with empty DataFrame
        empty_df = pd.DataFrame()
        with self.assertRaises(Exception):
            create_features(empty_df, "close")

        # Test with non-existent column
        df = self.test_df_btc.copy()
        with self.assertRaises(Exception):
            create_features(df, "non_existent_column")


if __name__ == "__main__":
    unittest.main(verbosity=2)
