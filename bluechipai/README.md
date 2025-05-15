# Blue Chip AI

## Overview
This Python project integrates external API data with a Cairo-based model that enables verifiable, proof-generating predictions for BTC and ETH buy signals in real time.

## Features
- Fetches price time series data for BTC and ETH from an external API.
- Sends the fetched data as parameters to an XGBoost STARK-verifiable ML model implemented in Cairo.
- Returns a real-time prediction indicating whether to buy or not for the evaluated asset.

## Prerequisites
- Python >= 3.12
- Scarb & Cairo 2.11.4
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://docs.swmansion.com/scarb/install.sh | sh -s -- -v 2.11.4
   ```

## Installation
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd bluechipai
   ```
2. Create a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate
   ```
3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
4. Build the Cairo models:
   ```bash
   scarb build cairo/model_btc
   scarb build cairo/model_eth
   ```
   
## Usage
1. Fetch price data from the external API.
2. Pass the data as input parameters to the XGBoost STARK-verifiable ML model.
3. Run the model to get predictions.
## API Endpoints

The application exposes the following endpoints through a REST API:

1. **`/api/v1/`**
   - Method: GET
   - Description: Health check endpoint that returns the service status

2. **`/api/v1/predictions/<asset>`**
   - Method: GET
   - Description: Predicts market behavior for a specific asset
   - URL parameters: `asset` (the asset symbol such as "BTC" or "BTC")
   - Response: Returns a prediction (Bull or Bear) for the specified asset

3. **`/api/v1/predictions/all`**
   - Method: GET
   - Description: Predicts market behavior for BTC and ETH
   - Response: Returns predictions for both assets

4. **`/api/v1/predictions/<asset>/features`**
   - Method: GET
   - Description: Retrieves the lagged return features for the asset (the asset symbol such as "BTC" or "ETH")
   - URL parameters: `asset` (the asset symbol such as "BTC" or "BTC")
   - Response: Returns a JSON object containing the calculated lagged return values for the asset` 

### Response Format

All responses follow a standardized format:
```json
{
  "success": true|false,
  "data": {
    "predictions": [
      {
        "asset": "BTC",
        "prediction": 1|2|3,
        "success": true|false,
        "error": "error message (only when success is false)"
      },
      {
        "asset": "ETH",
        "prediction": 1|2|3,
        "success": true|false,
        "error": "error message (only when success is false)"
      }
    ]
  },
  "error": "error message (only when success is false)"
}
```

The prediction field in the response data indicates the market direction:
1: Bull (upward trend expected)
2: Bear (downward trend expected)
3: Error in prediction

#### Example Response for `/api/v1/predictions/<asset>/features`
```json
{
  "success": true,
  "data": {
    "features": {
      "return_lag_1": 12345678,
      "return_lag_2": 23456789,
      "return_lag_3": 34567890,
      "is_first_parameter_negative": 2
    }
  }
}
```

### Example
To execute the project, run the following command, include de var DEBUG in ca:
```bash
python main.py
```
For development purposes, you can enable debug output with:
```bash
DEBUG=true python main.py
```

## Project Flow
1. **Data Fetching**: The project queries an external API to retrieve price time series data for BTC and ETH.
2. **Model Execution**: The fetched data is passed to an XGBoost STARK-verifiable ML model implemented in Cairo.
3. **Prediction**: The model processes the data and returns a real-time prediction (buy signal or not).

## File Structure
- `main.py`: Entry point of the project.
- `requirements.txt`: Project configuration and dependencies.
- `cairo/`: Contains the Cairo models for BTC and ETH.

## License
This project is licensed under the MIT License.