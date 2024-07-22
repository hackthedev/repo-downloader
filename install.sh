#!/bin/bash

# Define an array of GitHub repos in the format "owner/repo"
repos=(
    "user/repo"
)

# Function to download and extract the latest release from a repo
download_and_extract_latest_release() {
    repo=$1
    echo "Processing $repo..."

    # Construct the URL for the latest release
    url="https://api.github.com/repos/$repo/releases/latest"
    echo "Fetching release info from: $url"

    # Get the latest release download URL
    response=$(curl -s "$url")
    zipball_url=$(echo $response | grep -oP '"zipball_url": "\K(.*?)(?=")')

    if [ -z "$zipball_url" ]; then
        echo "Failed to get the latest release for $repo"
        return
    fi

    echo "Download URL: $zipball_url"

    # Download the latest release
    zip_path="latest.zip"
    curl -L -o "$zip_path" "$zipball_url"

    if [ ! -f "$zip_path" ]; then
        echo "Failed to download the latest release for $repo"
        return
    fi

    # Extract the release into a temporary directory
    temp_dir=$(mktemp -d)
    unzip -q "$zip_path" -d "$temp_dir"

    # Move the contents of the extracted folder to the current directory
    extracted_dir=$(find "$temp_dir" -mindepth 1 -maxdepth 1 -type d | head -n 1)
    if [ -d "$extracted_dir" ]; then
        mv "$extracted_dir"/* .
    fi

    # Clean up
    rm -rf "$temp_dir"
    rm "$zip_path"

    echo "Completed $repo"
}

# Iterate through each repo and process it
for repo in "${repos[@]}"; do
    download_and_extract_latest_release "$repo"
done

echo "All repositories processed."
