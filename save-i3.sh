#!/usr/bin/env bash
WORKSPACES_JSON=$(i3-msg -t get_workspaces)

# Extract and print the names of active workspaces
CURRENT_WORKSPACES=$(echo "$WORKSPACES_JSON" | jq -r '.[] |  .name')

# Create a directory with the current timestamp
TIMESTAMP=$(date +"%Y%m%d%H%M%S")
SAVE_DIR="$HOME/.i3/i3-resurrect/$TIMESTAMP" # Replace with your desired directory path

mkdir -p "$SAVE_DIR" # Create the directory

# Loop through the active workspace names
jq -c '.[] | .name' <<<"$WORKSPACES_JSON" | while read -r WORKSPACENAME; do
	# Remove quotes from the workspace name
	WORKSPACENAME="${WORKSPACENAME//\"/}"

	# Call i3-resurrect to save the state of the workspace in the created directory
	i3-resurrect save -w "$WORKSPACENAME" --swallow=class,instance,title --directory "$SAVE_DIR"
done
i3-resurrect save -w "__i3_scratch" --directory "$SAVE_DIR" --swallow=class,instance,title

PARENT_DIR=$(dirname "$SAVE_DIR")
ln -sfn "$SAVE_DIR" "$PARENT_DIR/last"

# Check and delete folders older than 5 days in the parent directory
find "$PARENT_DIR" -maxdepth 1 -type d -ctime +5 -exec rm -rf {} \;
