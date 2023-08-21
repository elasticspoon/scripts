#!/usr/bin/env bash
TARGET="$(find $HOME/Sync/Notes/Blog/ -name '*.md' | fzf)"

if ! [ "$TARGET" ]; then
	exit 1
fi

FILE_NAME=$(basename "$TARGET")
DIR_NAME=$(dirname "$TARGET")
TARGET_DIR="$(echo "$DIR_NAME" | sed 's/Sync\/Notes\/Blog/Projects\/site\/_posts/')"

if [ ! -d $"DIR_NAME" ]; then
	echo "Creating directory $TARGET_DIR"
	mkdir -p "$TARGET_DIR"
fi

cp -vr "$DIR_NAME" "$TARGET_DIR"
