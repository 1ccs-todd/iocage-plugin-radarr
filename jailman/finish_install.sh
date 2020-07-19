#!/usr/local/bin/bash
# This file contains the install script for radarr

#init jail
initblueprint "$1"

# Initialise defaults

# Check if dataset for completed download and it parent dataset exist, create if they do not.
createmount "$1" "${global_dataset_downloads}"
createmount "$1" "${global_dataset_downloads}"/complete /mnt/fetched

# Check if dataset for media library and the dataset for movies exist, create if they do not.
createmount "$1" "${global_dataset_media}"
createmount "$1" "${global_dataset_media}"/movies /mnt/movies


iocage exec "$1" chown -R radarr:radarr /usr/local/share/Radarr /config


iocage exec "$1" service radarr restart

exitblueprint "$1"
