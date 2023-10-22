#!/usr/bin/env bash
if [ "$1" ]; then
	TARGET="$1"
else
	TARGET="$(find $HOME/Sync/Notes/Blog/ -name '*.md' | fzf)"
fi

if ! [ "$TARGET" ]; then
	exit 1
fi

FILE_NAME=$(basename "$TARGET")
DIR_NAME=$(dirname "$TARGET")
TARGET_DIR="$(echo "$DIR_NAME" | sed 's/Sync\/Notes\/Blog/Projects\/site\/_posts/' | xargs dirname)"

cp -vr "$DIR_NAME" "$TARGET_DIR"

if [ ! "$1" ]; then
	echo ",copy-post $TARGET"
fi
