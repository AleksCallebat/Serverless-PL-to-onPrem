from flask import Flask, request, jsonify
import requests

app = Flask(__name__)

# Configuration for the on-prem bucket
ON_PREM_BUCKET_URL = "http://on-prem-bucket-url"  # Replace with your on-prem bucket URL
ON_PREM_BUCKET_API_KEY = "your-api-key"  # Replace with your API key or authentication token

@app.route('/proxy/<path:object_path>', methods=['GET', 'POST', 'PUT', 'DELETE'])
def proxy(object_path):
    """
    Proxy endpoint to interact with the on-prem bucket.
    Supports GET, POST, PUT, and DELETE methods.
    """
    # Construct the full URL for the on-prem bucket
    url = f"{ON_PREM_BUCKET_URL}/{object_path}"

    # Forward the headers and data from the client request
    headers = {key: value for key, value in request.headers if key != 'Host'}
    headers['Authorization'] = f"Bearer {ON_PREM_BUCKET_API_KEY}"  # Add authentication header

    try:
        # Forward the request to the on-prem bucket
        if request.method == 'GET':
            response = requests.get(url, headers=headers, params=request.args)
        elif request.method == 'POST':
            response = requests.post(url, headers=headers, json=request.json)
        elif request.method == 'PUT':
            response = requests.put(url, headers=headers, json=request.json)
        elif request.method == 'DELETE':
            response = requests.delete(url, headers=headers)
        else:
            return jsonify({"error": "Method not allowed"}), 405

        # Return the response from the on-prem bucket
        return (response.content, response.status_code, response.headers.items())
    except requests.exceptions.RequestException as e:
        return jsonify({"error": str(e)}), 500


if __name__ == '__main__':
    # Run the Flask app
    app.run(host='0.0.0.0', port=5000)