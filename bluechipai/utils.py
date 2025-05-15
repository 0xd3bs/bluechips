from flask import jsonify


def standard_response(success=True, data=None, error=None, status_code=200):
    """
    Creates a standardized response format for all API endpoints.

    Parameters:
    -----------
    - `success` (bool): Indicates if the operation was successful.
    - `data` (any): The data to be returned (if operation was successful).
    - `error` (str): Error message (if operation failed).

    Returns:
    --------
    - tuple: A tuple containing the JSON response and the HTTP status code.
    """
    response = {"success": success, "data": data if data is not None else {}}
    if error:
        response["error"] = error
    return jsonify(response), status_code
