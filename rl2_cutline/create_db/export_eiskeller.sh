#"/bin/bash
# ./export_eiskeller.sh
export "SPATIALITE_SECURITY=relaxed"
sqlite3 ../db/1926.berlin_eiskeller.db < ../sql/RL2_WriteGeoTiff.Eiskeller_1928.sql

exit 0;
