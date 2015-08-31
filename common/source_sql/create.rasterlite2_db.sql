SELECT DateTime('now'),'create.rasterlite2_db.sql [begin] ';
SELECT DateTime('now'),'Note the following must be done beforehand: export "SPATIALITE_SECURITY=relaxed [load_extension]"';
-- 'mod_rasterlite2' MUST be called first !
--- reason: there are common functions in both spatialite and rasterlite2
---> the spatialite version of these functions are dummy placeholders for the rasterlite2-api
----> the first one loaded is used, so 'rasterlite2' MUST be called first
SELECT load_extension('/usr/local/lib/mod_rasterlite2');
SELECT load_extension('/usr/local/lib/mod_spatialite');PRAGMA foreign_keys=1;
SELECT DateTime('now'),'command: InitSpatialMetadata(1)';
SELECT InitSpatialMetadata(1);
SELECT DateTime('now'),'Raster2 Version: ',RL2_Version(),' CPU Version: ',RL2_Target_CPU();
SELECT DateTime('now'),'command: CreateRasterCoveragesTable [raster_coverages]';
SELECT CreateRasterCoveragesTable();
SELECT CreateStylingTables();
SELECT DateTime('now'),'create.rasterlite2_db.sql [finished] [Habe fertig!]';
----
SELECT SE_UpdateRasterCoverageExtent(1);
SELECT SE_UpdateVectorCoverageExtent(1);
----
