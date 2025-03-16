#!/usr/bin/env bash

# Get the hostname of the current system
HOSTNAME=$(hostname)

# Configure outputs and workspaces based on hostname
case "$HOSTNAME" in
  "marc-pc")
    swaymsg output DP-1 mode 2560x1440@165Hz pos 0 0
    swaymsg output DP-2 pos 2560 0

    swaymsg workspace 1 output DP-1
    swaymsg workspace 2 output DP-1
    swaymsg workspace 3 output DP-1
    swaymsg workspace 4 output DP-1
    swaymsg workspace 5 output DP-2
    swaymsg workspace 6 output DP-2
    swaymsg workspace 7 output DP-2
    swaymsg workspace 8 output DP-1
    swaymsg workspace 9 output DP-2
    ;;

  "gast-pc")
    swaymsg output HDMI-A-1 pos 0 0
    swaymsg output HDMI-A-2 pos 1920 0

    swaymsg workspace 1 output HDMI-A-1
    swaymsg workspace 2 output HDMI-A-1
    swaymsg workspace 3 output HDMI-A-1
    swaymsg workspace 4 output HDMI-A-1
    swaymsg workspace 5 output HDMI-A-2
    ;;

  *)
    echo "No specific configuration for this hostname. Using Sway defaults."
    ;;
esac

