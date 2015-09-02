SELECT DateTime('now'),'update.rasterlite2_coverageextent.sql [begin] ';
SELECT DateTime('now'),'Note to complete the metadata definitions for all Coverages to be published as WMS layers. "';
-- avoid: the DB "../source_db/2010.berlin_k5_schmettau.db" doesn't contain any valid Raster or Vector Coverage
SELECT SE_UpdateRasterCoverageExtent(1);
SELECT SE_UpdateVectorCoverageExtent(1);
SELECT DateTime('now'),'update.rasterlite2_coverageextent.sql [finished] [Habe fertig!]';
----

