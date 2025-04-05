#!/bin/bash

# theme’s in the cloned folder
theme_path="$(pwd)/andrew_theme.omp.json"

# mac-only check
if [ "$(uname -s)" != "Darwin" ]; then
  echo "yo, this is mac-only (for now :v)."
  exit 1
fi

# make sure the theme’s there
if [ ! -f "$theme_path" ]; then
  echo "$theme_path file \"andrew_theme.omp.json\" ain’t here."
  exit 1
fi

# check if oh-my-posh is ready
if ! command -v oh-my-posh > /dev/null; then
  echo "dude, you need oh-my-posh first. run ./install.sh, then come back."
  exit 1
fi

# set up zsh
zsh_config="$HOME/.zshrc"
if [ ! -f "$zsh_config" ]; then
  touch "$zsh_config"
  echo "made a fresh .zshrc for ya"
fi

if ! grep -q "oh-my-posh init zsh" "$zsh_config"; then
  echo "adding the theme to your zsh..."
  echo "eval \"\$(oh-my-posh init zsh --config $theme_path) \" " >> "$zsh_config"
else
  echo "updating your zsh config..."
  sed -i '' "s|oh-my-posh init zsh --config .*|oh-my-posh init zsh --config $theme_path)\"|" "$zsh_config"
fi

echo "theme’s on! run 'source $zsh_config' or restart your terminal."