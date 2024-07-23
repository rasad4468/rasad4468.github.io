import requests
import json

# Define the Prism Central credentials and IP
prism_central_ip = 'your_prism_central_ip'
username = 'your_username'
password = 'your_password'

# Define the API endpoint
url = f'https://{prism_central_ip}:9440/api/nutanix/v3/clusters/list'

# Set up the request headers
headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
}

# Send a request to list clusters
response = requests.post(url, headers=headers, auth=(username, password), verify=False)

if response.status_code == 200:
    clusters = response.json()
    print(json.dumps(clusters, indent=4))
else:
    print(f"Error: {response.status_code}")

