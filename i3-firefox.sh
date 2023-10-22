#!/usr/bin/env bash
if ! pgrep 'firefox|MainThread' >/dev/null; then
	firefox &
fi
