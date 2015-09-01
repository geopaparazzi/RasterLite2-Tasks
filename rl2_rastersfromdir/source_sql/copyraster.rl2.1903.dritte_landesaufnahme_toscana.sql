SELECT DateTime('now'),'copyraster.rl2.1903.dritte_landesaufnahme_toscana [begin]';
SELECT DateTime('now'),'sample: sqlite3 1903.dritte_landesaufnahme_toscana.db < copyraster.rl2.1903.dritte_landesaufnahme_toscana.sql';
---
.read ../source_sql/create.database.sql
---
SELECT DateTime('now'),'CopyRasterCoverage: from 1903.dritte_landesaufnahme_toscana_file.db [dritte_landesaufnahme_toscana]';
-- Creating 'collection from single image and the image_fromdir
ATTACH DATABASE "../source_db/1903.dritte_landesaufnahme_toscana_file.db" AS db_import;
-- -
SELECT RL2_CopyRasterCoverage
(
  -- the prefix used when the Database was ATTACHed
 'db_import',
 -- the raster_coverage to copy from the ATTACHed Database
 'dritte_landesaufnahme_toscana'
);
-- CreateStylingTables() error: table 'SE_external_graphics' already exists
DETACH DATABASE db_import;
---
SELECT DateTime('now'),'CopyRasterCoverage: from 1903.dritte_landesaufnahme_toscana_dir.db [dritte_landesaufnahme_toscana_dir]';
ATTACH DATABASE "../source_db/1903.dritte_landesaufnahme_toscana_dir.db" AS db_import;
SELECT RL2_CopyRasterCoverage
(
  -- the prefix used when the Database was ATTACHed
 'db_import',
 -- the raster_coverage to copy from the ATTACHed Database
 'dritte_landesaufnahme_toscana_dir'
);
DETACH DATABASE db_import;
---
-- .read ../source_sql/update.rasterlite2_coverageextent.sql
SELECT DateTime('now'),'Note to complete the metadata definitions for all Coverages to be published as WMS layers. "';
SELECT SE_UpdateRasterCoverageExtent(1);
SELECT SE_UpdateVectorCoverageExtent(1);
---
SELECT DateTime('now'),'VACUUM';
-- VACUUM;
SELECT DateTime('now'),'copyraster.rl2.1903.dritte_landesaufnahme_toscana [finished] [Habe fertig!]';
