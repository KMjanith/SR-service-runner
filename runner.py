import requests
import os

def get_latest_tag(repo_name):
    url = f"https://registry.hub.docker.com/v2/repositories/{repo_name}/tags"
    response = requests.get(url)
    tags = response.json()
    latest_tag = tags['results'][0]['name']
    return latest_tag

# Fetch the latest tag for each service
auth_service_tag = get_latest_tag("mjanith/authservice")
api_gateway_tag = get_latest_tag("mjanith/apigateway")
sorting_tag = get_latest_tag("mjanith/sorting")

print(f"Latest tag for auth service: {auth_service_tag}")
print(f"Latest tag for api gateway: {api_gateway_tag}")
print(f"Latest tag for sorting: {sorting_tag}")

# Write the tags to an .env file
with open('.env', 'w') as env_file:
    env_file.write(f"AUTH_TAG={auth_service_tag}\n")
    env_file.write(f"API_TAG={api_gateway_tag}\n")
    env_file.write(f"SORT_TAG={sorting_tag}\n")

print("Latest tags fetched")
print("starting services...")