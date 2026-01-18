nrs() {
#  cd ~/nixos-dotfiles || return 1
#  git add -A
#
#  files=$(git diff --name-only)
#  if [ -n "$files" ]; then
#    msg="Update $(echo "$files" | paste -sd ', ' -)"
#    git commit -m "$msg"
#  else
#    echo "No changes to commit"
#  fi

  sudo nixos-rebuild switch --flake ~/nixos-dotfiles#hyprland
}

nrs
