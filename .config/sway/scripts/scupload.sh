#!/usr/bin/env bash

# Konfiguration
DIRECTORY="$HOME/Pictures/Quicksnap"
FILENAME=$(date +screenshot-%Y-%m-%d-%H-%M-%S.png)
UPLOADURL="ENTER URL"
SECRET_FILE="$HOME/.screenshotsecret"

# Stelle sicher, dass das Secret existiert
if [[ ! -f "$SECRET_FILE" ]]; then
    notify-send -t 2000 -i error "Upload Error" "Secret file not found!"
    echo "Error: Secret file $SECRET_FILE not found!"
    exit 1
fi

SECRET=$(<"$SECRET_FILE")

grimshot copy area > /dev/null 2>&1

# Stelle sicher, dass wl-paste ein Bild enthält
if ! wl-paste --type image/png > /dev/null 2>&1; then
    notify-send -t 2000 -i error "Upload Error" "Clipboard does not contain an image!"
    echo "Error: Clipboard does not contain an image!"
    exit 1
fi

# Stelle sicher, dass das Verzeichnis existiert
mkdir -p "$DIRECTORY"

# Screenshot speichern
if ! wl-paste --type image/png > "$DIRECTORY/$FILENAME"; then
    notify-send -t 2000 -i error "Upload Error" "Failed to save screenshot!"
    echo "Error: Failed to save screenshot!"
    exit 1
fi

# Datei-Upload
RESPONSE=$(curl -s --fail -F "secret=$SECRET" -F "sharex=@$DIRECTORY/$FILENAME" "$UPLOADURL")

# Prüfen, ob der Upload erfolgreich war
if [[ -z "$RESPONSE" || "$RESPONSE" == *"Error"* ]]; then
    notify-send -t 2000 -i error "Upload Error" "Server response: $RESPONSE"
    echo "Error: Server response: $RESPONSE"
    exit 1
fi

# Link in die Zwischenablage kopieren und anzeigen
echo "$RESPONSE" | wl-copy
notify-send -t 5000 -i info "Upload Complete" "$RESPONSE"
echo "$RESPONSE"

