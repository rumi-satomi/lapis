#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TRACKED_FILES="$SCRIPT_DIR/tracked-files.txt"
FILES_DIR="$SCRIPT_DIR/files"

MODE="${1:-}"

# Validate mode
if [[ "$MODE" != "pull" && "$MODE" != "push" ]]; then
	echo "Usage: $0 [pull|push]"
	exit 1
fi

# Ensure tracked-files.txt exists
if [[ ! -f "$TRACKED_FILES" ]]; then
	echo "Error: tracked-files.txt not found!"
	echo "Expected location: $TRACKED_FILES"
	exit 1
fi

mkdir -p "$FILES_DIR"

# Convert absolute path
repo_path_for() {
	local abs="$1"

	#remove leading slash
	local clean="${abs#/}"

	echo "$FILES_DIR/$clean"
}

# Main loop
while IFS= read -r ABS_PATH || [[ -n "$ABS_PATH" ]]; do
	# Skip comments and empty lines
	[[ -z "$ABS_PATH" ]] && continue
	[[ "$ABS_PATH" =~ ^# ]] && continue

	REPO_PATH="$(repo_path_for "$ABS_PATH")"
	
	# Device => Repo
	if [[ "$MODE" == "pull" ]]; then
		if [[ -f "$ABS_PATH" ]]; then
			mkdir -p "$(dirname "$REPO_PATH")"

			cp "$ABS_PATH" "$REPO_PATH"

			echo "[PULL] $ABS_PATH"
		else
			echo "[MISSING] $ABS_PATH"
		fi
	fi

	# Repo => Device
	if [[ "$MODE" == "push" ]]; then
		if [[ -f "$REPO_PATH" ]]; then
			sudo mkdir -p "$(dirname "$ABS_PATH")"

			sudo cp "$REPO_PATH" "$ABS_PATH"

			echo "[PUSH] $ABS_PATH"
		else
			echo "[MISSING IN REPO] $REPO_PATH"
		fi
	fi
done < "$TRACKED_FILES"

echo "Done"
