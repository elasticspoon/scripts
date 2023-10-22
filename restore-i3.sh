#!/usr/bin/env bash

# Directory where the i3-resurrect workspace states are stored
RESURRECT_DIR="$HOME/.i3/i3-resurrect/last"

# Check if the directory exists
if [ ! -d "$RESURRECT_DIR" ]; then
	echo "Error: i3-resurrect directory not found: $RESURRECT_DIR"
	exit 1
fi

for FILE in "$RESURRECT_DIR"/*_programs.json; do
	if [ -f "$FILE" ]; then
		# Extract workspace number from the filename
		WORKSPACE_NUMBER=$(basename "$FILE" | awk -F_ '{print $2}')

		if [ ! "$WORKSPACE_NUMBER" ]; then
			i3-resurrect restore -w "__i3_scratch" --programs-only --directory "$RESURRECT_DIR"
			i3-resurrect restore -w "__i3_scratch" --layout-only --directory "$RESURRECT_DIR"
		fi
		# Restore programs for the workspace
		i3-resurrect restore -w "$WORKSPACE_NUMBER" --programs-only --directory "$RESURRECT_DIR"

		# Restore layout for the workspace
		i3-resurrect restore -w "$WORKSPACE_NUMBER" --layout-only --directory "$RESURRECT_DIR"
	fi
done
