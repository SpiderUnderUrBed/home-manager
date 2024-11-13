
commandline="${*:1}"
CLASS="$1"
ACTIVE_WORKSPACE="$(hyprctl activeworkspace -j | jq -r .id)"

TEMP=$(getopt -q --longoptions class: -n 'hdrop' -- "$@")

eval set -- "$TEMP"

while true; do
  case "$1" in
  --class)
    CLASS="$2"
    shift 2
    ;;
  --)
    shift
    break
    ;;
  *) break ;;
  esac
done

if [[ $(hyprctl clients -j | jq -r ".[] | select(.class==\"$CLASS\" and .workspace.id!=$ACTIVE_WORKSPACE)") ]]; then
  hyprctl dispatch -- movetoworkspacesilent $ACTIVE_WORKSPACE,"$CLASS"
  hyprctl dispatch -- focuswindow "$CLASS"
elif [[ $(hyprctl clients -j | jq -r ".[] | select(.class==\"$CLASS\" and .workspace.id==$ACTIVE_WORKSPACE)") ]]; then
  hyprctl dispatch -- movetoworkspacesilent special,"$CLASS"
else
  hyprctl dispatch -- exec $commandline
fi
