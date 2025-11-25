TOGGLE=/tmp/droptoggle
LAST_TOGGLE_FILE=/tmp/droptoggle_last
DROPTERM=kitty-dropdown
COOLDOWN=2  # Set cooldown in seconds
 
ACTIVE_MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')

fade_in() {
    for i in {0..10}; do
        alpha=$((i))
        hyprctl setprop class:$DROPTERM alpha $(echo "scale=1; $alpha / 10" | bc)
        sleep 0.05
    done
}
 
fade_out() {
    for i in {10..0}; do
        alpha=$((i))
        hyprctl setprop class:$DROPTERM alpha $(echo "scale=1; $alpha / 10" | bc)
        sleep 0.05
    done
}
 
# Check if last toggle was within cooldown period
if [ -f "$LAST_TOGGLE_FILE" ]; then
    LAST_TOGGLE=$(cat "$LAST_TOGGLE_FILE")
    CURRENT_TIME=$(date +%s)
    ELAPSED=$((CURRENT_TIME - LAST_TOGGLE))
    if [ "$ELAPSED" -lt "$COOLDOWN" ]; then
        echo "Cooldown in effect. Please wait $((COOLDOWN - ELAPSED)) seconds."
        exit 0
    fi
fi
 
# Update the last toggle time
date +%s > "$LAST_TOGGLE_FILE"
 
# Main toggle logic
if [ -f "$TOGGLE" ]; then
    hyprctl --batch "dispatch movewindowpixel 0 -500,$DROPTERM; dispatch pin $DROPTERM; dispatch cyclenext;"
    fade_out
#    fade_in
    rm "$TOGGLE"
else
    hyprctl --batch "dispatch movewindow mon:$ACTIVE_MONITOR; dispatch movewindowpixel 0 500,$DROPTERM; dispatch pin $DROPTERM; dispatch focuswindow $DROPTERM;"
    fade_in
#    fade_out
    touch "$TOGGLE"
fi
