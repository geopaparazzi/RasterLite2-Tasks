SELECT DateTime('now'),'create.rasterlite2_db.sql [begin] ';
SELECT DateTime('now'),'Note the following must be done beforehand: export "SPATIALITE_SECURITY=relaxed [load_extension]"';
SELECT load_extension('/usr/local/lib/mod_rasterlite2');
SELECT DateTime('now'),'Raster2 Version: ',RL2_Version(),' CPU Version: ',RL2_Target_CPU();
SELECT DateTime('now'),'command: CreateRasterCoveragesTable [raster_coverages]';
SELECT CreateRasterCoveragesTable();
SELECT CreateStylingTables();
SELECT DateTime('now'),'create.rasterlite2_db.sql [finished] [Habe fertig!]';
----
SELECT SE_UpdateRasterCoverageExtent(1);
SELECT SE_UpdateVectorCoverageExtent(1);
----
