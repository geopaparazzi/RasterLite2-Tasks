SELECT DateTime('now'),'create.spatialite_db.sql [begin] ';
SELECT DateTime('now'),'load_extension: mod_spatialite, with activated FK constraints.';
-- sqlite3 always starts by keeping FK constraints completely disabled
-- spatialite CLI and spatialite GUI always implicitly activate FK constraints every time you'll start a DB connection
SELECT load_extension('/usr/local/lib/mod_spatialite');PRAGMA foreign_keys=1;
SELECT DateTime('now'),'command: InitSpatialMetadata(1)';
SELECT InitSpatialMetadata(1);
SELECT DateTime('now'),'create.spatialite_db.sql [finished] [Habe fertig!]';
