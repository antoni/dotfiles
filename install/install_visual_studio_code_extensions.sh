#!/usr/bin/env bash

extensions=(
	pflannery.vscode-versionlens
	Gruntfuggly.todo-tree
	ChakrounAnas.turbo-console-log
	darkriszty.markdown-table-prettify
	sysoev.vscode-open-in-github
	GitHub.vscode-github-actions
	wengerk.highlight-bad-chars
	davidfreer.go-to-character-position
	Infracost.infracost
	JeffJorczak.auto-translate-json
)

args=()
for ext in "${extensions[@]}"; do
  args+=(--install-extension "$ext")
done

NODE_NO_WARNINGS=1 code --force "${args[@]}"