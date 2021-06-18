#!/bin/sh

# This script calls the convert.sh script with the following settings:
# * creates a mapset directory to store the resulting converted maps in.
# * A variable that stores the file name of the shapefile to process.
# * A variable that stores the names of the directories to grab these shapefiles from.
set -e

MAP_DIR="mapset"
SHAPEFILE_NAME="Streets.shp"
SHAPEFILE_DIRS=shapefiles/*/

# run it !

mkdir -p "${MAP_DIR}"
for i in ${SHAPEFILE_DIRS}; \
	do ./convert.sh ${SHAPEFILE_DIRS}/${SHAPEFILE_NAME} && \
	mv out.bin mapset/"$(basename "$i")".bin; \
	done
