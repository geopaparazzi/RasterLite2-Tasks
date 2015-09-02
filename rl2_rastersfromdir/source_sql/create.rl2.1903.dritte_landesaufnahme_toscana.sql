SELECT DateTime('now'),'createraster.rl2_Dritte_Landesaufnahme.Toscana [begin]';
-- export SPATIALITE_SECURITY=relaxed
SELECT DateTime('now'),'sample: sqlite3 dritte_landesaufnahme_toscana.db < createraster.rl2_Dritte_Landesaufnahme.Toscana.sql';
-- SELECT DateTime('now'),'Note the following must be done beforehand: export "SPATIALITE_SECURITY=relaxed"';
---
.read ../source_sql/create.database.sql
---
--- sqlite3_step() error: INSERT INTO raster_coverages "FOREIGN KEY constraint failed
---> misstyped srid (5505 instead of 4805)
----
SELECT DateTime('now'),'command: RL2_CreateRasterCoverage : dritte_landesaufnahme_toscana - Size 16952, 12714';
 SELECT RL2_CreateRasterCoverage
(
 'dritte_landesaufnahme_toscana', -- chosen name of raster_coverage
 'UINT8', -- Data-Type of Image
 'RGB', -- Image-Type of Image
 3, -- Amount of Bands in the Image
 'JPEG',  -- chosen Compression to be used
 80, --- quality: only used for JPEG
 512, -- tile-size-x
 512, -- tile-size-y
 4805, -- srid of Image being read [MGI (Ferro), Militar_Geographische_Institut_Ferro]
 0.000235960358660, -- Resolution_X / Pixel Size of gdalinfo (gdalbuildvrt -resolution highest)
 0.000235960358660, -- Resolution_Y / Pixel Size of gdalinfo (gdalbuildvrt -resolution highest)
 NULL, -- no_data: will create default values [default_nodata(sample, pixel, num_bands)]
 0, --  strict_resolution: default 0
 1, -- mixed_resolutions: default 0 ; 1= allows mxxed resolutions horz/vert_resolution=999999.999999
 0, -- section_paths: default 0
 0, -- section_md5: default 0
 0 -- section_summary: default 0
);
SELECT DateTime('now'),'command: RL2_SetPixelValue(nodata_pixel,0/1/2,128)';
-- SELECT DateTime('now'),'command: replacing the default nodata_pixel value of "#FFFFFF" to "#C0C0C0"';
UPDATE raster_coverages SET nodata_pixel = RL2_SetPixelValue(nodata_pixel,0,128) WHERE coverage_name = 'dritte_landesaufnahme_toscana';
UPDATE raster_coverages SET nodata_pixel = RL2_SetPixelValue(nodata_pixel,1,128) WHERE coverage_name = 'dritte_landesaufnahme_toscana';
UPDATE raster_coverages SET nodata_pixel = RL2_SetPixelValue(nodata_pixel,2,128) WHERE coverage_name = 'dritte_landesaufnahme_toscana';
---
SELECT DateTime('now'),'command: RL2_SetRasterCoverageInfos - title and abstract text';
SELECT RL2_SetRasterCoverageInfos('dritte_landesaufnahme_toscana','1903-1912 - Dritte Landesaufnahme (Franzisco-Josephinische) Österreich - 1:200000','Area of Toscana - Southern portion of Ravenna missing in original image. 1 Geo-Tiff Image 290.1 MB');
---
SELECT DateTime('now'),'command: RL2_LoadRaster : dritte_landesaufnahme_toscana : dritte_landesaufnahme_toscana [] time_run[]';
SELECT RL2_LoadRaster
(
 -- chosen name of raster_coverage
 'dritte_landesaufnahme_toscana', 
  -- path to the file to be loaded
 '../source_image/1903.dritte_landesaufnahme_toscana.200000.4805.tif'
);
--- Error: near line 48: no such function: RL2_LoadRastersFromDir
----> forgot 'export SPATIALITE_SECURITY=relaxed'
-- SELECT RL2_LoadRastersFromDir('dritte_landesaufnahme_toscana','../Dritte_Landesaufnahme.Toscana','.tif');
SELECT DateTime('now'),'command: RL2_LoadRaster : db [55.5.MB] time_run_jpeg[4 mins 22 secs]';
-- SELECT SE_RegisterRasterStyledLayer('dritte_landesaufnahme_toscana',XB_Create(XB_LoadXML('../dritte_landesaufnahme_toscana/DIFF1.3_2012_000415_geo_1m.sld'), 1, 1));
----
--            Importing: ../Dritte_Landesaufnahme.Toscana.200000.4805.tif
--    Image Size (pixels): 16952 x 12714
--                   SRID: 4805
--       LowerLeft Corner: X=26.50 Y=41.50
--      UpperRight Corner: X=30.50 Y=44.50
--       Pixel resolution: X=0.0002359603586597451 Y=0.0002359603586597451
--- >> Image successfully imported in: 4 mins 22 secs
-- Note: returns with rc=1 ; db [55.5.MB] without RL2_PyramidizeMonolithic
----
--- SELECT DateTime('now'),'command: RL2_Pyramidize';
--- SELECT RL2_Pyramidize('dritte_landesaufnahme_toscana','1811.Selter_Grundriss_von_Berlin.5800.3068',0,0);
----
SELECT DateTime('now'),'command: RL2_PyramidizeMonolithic : dritte_landesaufnahme_toscana';
SELECT RL2_PyramidizeMonolithic('dritte_landesaufnahme_toscana');
SELECT DateTime('now'),'command(s): SE_UpdateRasterCoverageExtent/SE_UpdateVectorCoverageExtent';
-- the DB "dritte_landesaufnahme_toscana_dir.db" doesn't contain any valid Raster or Vector Coverage
--> cause: missing SE_UpdateRasterCoverageExtent/SE_UpdateVectorCoverageExtent
---
.read ../source_sql/update.database.sql
---
-- VACUUM;
SELECT DateTime('now'),'createraster.rl2_Dritte_Landesaufnahme.Toscana [finished] [Habe fertig!]';
