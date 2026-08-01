{
  pkgs,
  lib,
  config,
  ...
}: let
  animationSpeed = config.theme.animation_speed;

  animationDuration =
    if animationSpeed == "slow"
    then "4"
    else if animationSpeed == "medium"
    then "2.5"
    else "1.5";
  borderDuration =
    if animationSpeed == "slow"
    then "10"
    else if animationSpeed == "medium"
    then "6"
    else "3";
in {
}
