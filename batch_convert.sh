#!/bin/sh

# This script calls the convert.sh script with the following settings:
# * creates a mapset directory to store the resulting converted maps in.
# * A counter variable for the number of map directories found.
# * A counter that stores the number of shapefiles to process.
# * A counter that stores the number of already processed maps.
# * A variable that stores the file name of the shapefile to process.
# * A variable that stores the names of the directories to grab these shapefiles from.
# * A variable that stores the base name of the shapefiles directory (shapefiles by default).

set -e

SHAPEFILE_DIRS_COUNTER=0
CONVERTED_MAP_COUNTER=0
MAP_DIR="mapset"
SHAPEFILE_NAME="Streets.shp"
BASE_SHAPEFILE_DIR="shapefiles"
SHAPEFILE_DIRS=$BASE_SHAPEFILE_DIR/*/

# run it !

mkdir -p "${MAP_DIR}"

if test -d "${BASE_SHAPEFILE_DIR}"; then
	echo "### SHAPEFILES DIRECTORY PRESENT ###"
else
	echo "### !SHAPEFILES DIRECTORY MISSING! ###"
	echo "Please create the shapefiles directory in the translations directory, and place the map directories containing shapefiles inside."
	echo "e.g: shapefiles/mapset/E2AM151H0EE2000AABCS/Streets.shp"
	echo "And run this script again."
	exit 1
fi

for i in ${SHAPEFILE_DIRS}; do \
	if test -d "${i}"; then \
		SHAPEFILE_DIRS_COUNTER=$((SHAPEFILE_DIRS_COUNTER+1)); \
	else \
		echo "### !ONE OR MORE MAP DIRECTORIES MISSING! ###"; \
		echo "Please place the map directories containing shapefiles in the shapefiles directory."; \
		echo "e.g: shapefiles/E2AM151H0EE2000AABCS"; \
		echo "And run this script again."; \
		exit 1; \
fi \
done

echo "### "${SHAPEFILE_DIRS_COUNTER}" MAP DIRECTORIES WERE FOUND ###"

for i in ${SHAPEFILE_DIRS}/"${SHAPEFILE_NAME}"; do \
	if test -f "${i}"; then \
		SHAPEFILE_COUNTER=$((SHAPEFILE_COUNTER+1)); \
	else \
		echo "### !SHAPEFILES FILE MISSING! ###"; \
		echo "Please make sure the map directories placed in the shapefiles directory contain shapefiles files, in particular the ones you wish to convert."; \
		echo "The default shapefile name this scripts looks for is Streets.shp."; \
		echo "e.g: shapefiles/mapset/E2AM151H0EE2000AABCS/Streets.shp"; \
		echo "And run this script again."; \
		exit 1; \
	fi \
done

echo "### "${SHAPEFILE_COUNTER}" SHAPEFILES FILES FOUND ###"

for i in ${SHAPEFILE_DIRS}; do \
	if ! test -f "${MAP_DIR}"/"$(basename "${i}")".bin; then
		./convert.sh "${i}"/"${SHAPEFILE_NAME}" && \
		mv out.bin ${MAP_DIR}/"$(basename "${i}")".bin; \
		printf "<map type=\"binfile\" data=\"\$NAVIT_SHAREDIR/maps/"$(basename "${i}")".bin\" />" > "${MAP_DIR}"/"$(basename "${i}")".xml; \
	fi
done

echo "### NO MORE SHAPEFILES TO CONVERT, EXITTING ###"
