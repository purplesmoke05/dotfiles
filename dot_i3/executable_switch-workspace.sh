#!/bin/bash -eu
#
# Usage:
#  $ TARGET_NUMBER=1 ./switch-workspace.sh
#  $ TARGET_NUMBER=2 MOVE_CONTAINER=true ./switch-workspace.sh

declare -r RIGHT_SCREEN="DP-0"
declare -r LEFT_SCREEN="HDMI-0"

main () {
  # 現在の出力（モニタ）を取得
  local focused_output=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).output')

  local ws
  # 出力に応じてワークスペースを切り替え
  if [ "$focused_output" == "$LEFT_SCREEN" ]; then
    ws="$TARGET_NUMBER:left$TARGET_NUMBER"
  elif [ "$focused_output" == "$RIGHT_SCREEN" ]; then
    ws="1$TARGET_NUMBER:right$TARGET_NUMBER"
  else
    return 1
  fi

  if [ -n "${MOVE_CONTAINER:-}" ]; then
    i3-msg move container to workspace "$ws"
  fi
  i3-msg workspace "$ws"
}

main "$@"
