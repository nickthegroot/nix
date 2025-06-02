{ pkgs, lib, ... }:
{
  services.sketchybar.enable = true;

  services.aerospace.settings.exec-on-workspace-change = [
    "/bin/bash"
    "-c"
    "${lib.getExe pkgs.sketchybar} --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE"
  ];
}
