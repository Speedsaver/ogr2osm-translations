#!/bin/sh
# Example use: mkdir mapset; for i in ../../E*; do ./convert.sh $i/Streets.shp && mv out.bin mapset/$(basename $i).bin; done
set -e
echo "#### RUNNING OGR2OSM ####"
python3 ../ogr2osm.py -t speedsaver --positive-id --force -o convert.osm "$1"
echo "#### LINTING MAP ####"
xmllint --pretty 1 convert.osm > linted.osm
echo "#### RUNNING MAPTOOL ####"
./maptool -U out.bin < linted.osm
echo "#### CLEANING UP ####"
rm convert.osm
rm linted.osm
