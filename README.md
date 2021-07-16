# ogr2osm-translations
Speedsaver variant of ogr2osm-translations

git clone --recursive https://github.com/speedsaver/ogr2osm && cd ogr2osm
git pull --recurse-submodules && cd translations
place a copy of maptool in the translations directory
create shapefiles folder in translations directory, place shapefiles in it and run:
./batch_convert.sh
OR for individual ad hoc files e.g. OSM, place in translations directory and run:
./convert.sh yourfile.shp
