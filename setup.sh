#!/bin/bash

# Ensure necessary directories exist
mkdir -p ~/.config ~/.local/bin ~/.local/share/applications

# Log file for actions
LOG_FILE=./dotfiles_setup.log
exec > >(tee -a "$LOG_FILE") 2>&1

# Link configuration directories
for dir in ~/dotfiles/*; do
    dir=$(basename "$dir")
    if [[ "$dir" == "applications" || "$dir" == "bin" ]]; then
        continue
    fi
    if [[ -L ~/.config/$dir ]]; then
        if [[ "$(readlink ~/.config/$dir)" == "$HOME/dotfiles/$dir" ]]; then
            echo "Skipping up-to-date symlink for $dir"
            continue
        else
            echo "Updating outdated symlink for $dir"
            ln -sfT ~/dotfiles/$dir ~/.config/$dir || echo "Failed to update symlink for $dir"
            continue
        fi
    fi
    echo "Linking $dir to ~/.config/$dir"
    ln -sfT ~/dotfiles/$dir ~/.config/$dir || echo "Failed to link $dir"
done

# Link bin files
echo "Linking bin files to ~/.local/bin"
find ~/dotfiles/bin -type f -exec ln -sf {} ~/.local/bin/ \; || echo "Failed to link bin files"

# Link application files
echo "Linking application files to ~/.local/share/applications"
find ~/dotfiles/applications -type f -exec ln -sf {} ~/.local/share/applications/ \; || echo "Failed to link application files"

echo "Dotfiles installed!"
