#!/bin/sh

max_length=15

while true; do
    # Überprüfen, ob playerctl verfügbar ist, sonst "None" ausgeben
    playerctl status >/dev/null 2>&1 || { echo "◼︎ None"; sleep 1; continue; }

    # Player-Informationen sammeln
    player_status=$(playerctl status 2>/dev/null)
    player_artist=$(playerctl metadata artist 2>/dev/null)
    player_title=$(playerctl metadata title 2>/dev/null)

    # Zeichenketten kürzen
    [ ${#player_artist} -gt $max_length ] && player_artist="${player_artist:0:$((max_length - 3))}..."
    [ ${#player_title} -gt $max_length ] && player_title="${player_title:0:$((max_length - 3))}..."

    # Status ausgeben
    [ "$player_status" = "Paused" ] && echo "𝚰𝚰 $player_artist - $player_title"
    [ "$player_status" = "Playing" ] && echo "⊳ $player_artist - $player_title"

    # Eine Sekunde warten, bevor die nächste Schleifeniteration beginnt
    sleep 1
done

