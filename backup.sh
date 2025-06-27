#!/bin/bash

# Define the network path for offload
NETWORK_BACKUP_DIR="/mnt/dm-wrdn/backups"

# Define the base backup directory
BACKUP_BASE_DIR="/mnt/dumpy/backup"

# Define the base SteamLibrary path
STEAM_BASE_DIR="/mnt/dumpy/SteamLibrary/steamapps"

# Define the evetools folders
EVE_TOOLS_DIR="/mnt/dumpy/evetools"

# Generate the date-stamped directory name
TIMESTAMP=$(date +"%Y-%m-%d")
BACKUP_DIR="${BACKUP_BASE_DIR}/${TIMESTAMP}"

# Create the backup directory

mkdir -p "${BACKUP_DIR}" || { echo "Error: Could not create backup directory."; exit 1; }

# Example: Copy files to the backup directory

# Home directory
rsync -avzR ~/.jeveassets "${BACKUP_DIR}/"
rsync -avzR ~/.pyfa "${BACKUP_DIR}/"
rsync -avzR ~/.rift "${BACKUP_DIR}/"
rsync -avzR ~/Mumble "${BACKUP_DIR}/"
rsync -avzR ~/Pictures "${BACKUP_DIR}/"

# .cache directory
rsync -avzR ~/.cache/dzgui "${BACKUP_DIR}/"
rsync -avzR ~/.cache/fyne "${BACKUP_DIR}/"
rsync -avzR ~/.cache/RIFT "${BACKUP_DIR}/"

# .config directory
rsync -avzR ~/.config/dztui "${BACKUP_DIR}/"
rsync -avzR ~/.config/fyne "${BACKUP_DIR}/"
rsync -avzR ~/.config/Mumble "${BACKUP_DIR}/"
rsync -avzR ~/.config/RIFT "${BACKUP_DIR}/"

# .local/share directory
rsync -avzR ~/.local/share/dzgui "${BACKUP_DIR}/"
rsync -avzR ~/.local/share/evebuddy "${BACKUP_DIR}/"
rsync -avzR ~/.local/share/Mumble "${BACKUP_DIR}/"
rsync -avzR ~/.local/share/pyfa.py "${BACKUP_DIR}/"

# .local/state directory
rsync -avzR ~/.local/state/dzgui "${BACKUP_DIR}/"

# EVE Steam folders
rsync -avzR "${STEAM_BASE_DIR}/compatdata/8500/pfx/drive_c/users/steamuser/AppData/Local/CCP/EVE" "${BACKUP_DIR}/"
rsync -avzR "${STEAM_BASE_DIR}/compatdata/8500/pfx/drive_c/users/steamuser/AppData/Roaming/EVE Online" "${BACKUP_DIR}/"

# evetools
rsync -avzR ${EVE_TOOLS_DIR} "${BACKUP_DIR}/"

# compress it
7z a -r "${BACKUP_DIR}.7z" ${BACKUP_DIR}
echo "Backup created in: ${BACKUP_DIR}"

# Upload it
cp "${BACKUP_DIR}.7z" ${NETWORK_BACKUP_DIR}

echo "Backup uploaded to: ${NETWORK_BACKUP_DIR}"
