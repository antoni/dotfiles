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

for extension in "${extensions[@]}"; do
  code --install-extension "$extension"
done
