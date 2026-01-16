nrs() {
  cd ~/nixos-dotfiles || return 1

  files=$(git diff --name-only)
  if [ -n "$files" ]; then
    git add -A
    msg="Update $(echo "$files" | paste -sd ', ' -)"
    git commit -m "$msg"
  else
    echo "No changes to commit"
  fi

  sudo nixos-rebuild switch --flake ~/nixos-dotfiles#hyprland
}

nrs
