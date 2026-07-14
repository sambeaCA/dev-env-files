#!/bin/bash

for sid in $(aerospace list-workspaces --all); do
  # Resolve app name for icon mapping and display label
  case "$sid" in
    "B") app="Safari";        label="$sid: Web"      ;;
    "M") app="Music";         label="$sid: Music"    ;;
    "N") app="Obsidian";      label="$sid: Obsidian" ;;
    "O") app="OBS";           label="$sid: OBS"      ;;
    "S") app="Messages";      label="$sid: Social"   ;;
    "T") app="iTerm2";          label="$sid: Code"     ;;
    "V") app="Final Cut Pro"; label="$sid: Editing"  ;;
    *)   app="";              label="$sid"            ;;
  esac

  sketchybar --add item space.$sid left \
      --subscribe space.$sid aerospace_workspace_change \
      --set space.$sid \
      label.color=$ACCENT_COLOR \
      background.color=$BAR_COLOR \
      background.corner_radius=5 \
      background.height=20 \
      background.drawing=off \
      icon.font="sketchybar-app-font:Regular:16.0" \
      icon.drawing="$([ -n "$app" ] && echo on || echo off)" \
      icon="$([ -n "$app" ] && "$PLUGIN_DIR/icon_map_fn.sh" "$app")" \
      label="$label" \
      click_script="aerospace workspace $sid" \
      script="$PLUGIN_DIR/aerospace.sh $sid"
done
