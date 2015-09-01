SELECT DateTime('now'),'createrasters_fromdir.rl2_Dritte_Landesaufnahme.Toscana [begin]';
-- export SPATIALITE_SECURITY=relaxed
SELECT DateTime('now'),'sample: sqlite3 dritte_landesaufnahme_toscana_dir.db < createrasters_fromdir.rl2_Dritte_Landesaufnahme.Toscana.sql';
-- wmslite -p 8081 -db dritte_landesaufnahme_toscana_dir.db &
--> results are incorrect
---> only 3 maps of 9 are shown
-- wmslite -p 8082 -db dritte_landesaufnahme_toscana.db &
-- LibreWMS &
-- SELECT DateTime('now'),'Note the following must be done beforehand: export "SPATIALITE_SECURITY=relaxed"';
---
.read ../source_sql/create.database.sql
---
--- sqlite3_step() error: INSERT INTO raster_coverages "FOREIGN KEY constraint failed
---> misstyped srid (5505 instead of 4805)
----
SELECT DateTime('now'),'command: RL2_CreateRasterCoverage : dritte_landesaufnahme_toscana_dir - Size 16952, 12714';
SELECT RL2_CreateRasterCoverage
(
 'dritte_landesaufnahme_toscana_dir', -- chosen name of raster_coverage
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
 1, -- mixed_resolutions: default 0 ; 1= allows mixed resolutions horz/vert_resolution=999999.999999
 0, -- section_paths: default 0
 0, -- section_md5: default 0
 0 -- section_summary: default 0
);
--- 'Coverage/TIFF mismatch' : in the directory a tiff existed with another srid (32632)
---> after removing srid=32632 files, runs correctly
SELECT DateTime('now'),'command: RL2_SetPixelValue(nodata_pixel,0/1/2,128)';
-- SELECT DateTime('now'),'command: replacing the default nodata_pixel value of "#FFFFFF" to "#C0C0C0"';
UPDATE raster_coverages SET nodata_pixel = RL2_SetPixelValue(nodata_pixel,0,128) WHERE coverage_name = 'dritte_landesaufnahme_toscana_dir';
UPDATE raster_coverages SET nodata_pixel = RL2_SetPixelValue(nodata_pixel,1,128) WHERE coverage_name = 'dritte_landesaufnahme_toscana_dir';
UPDATE raster_coverages SET nodata_pixel = RL2_SetPixelValue(nodata_pixel,2,128) WHERE coverage_name = 'dritte_landesaufnahme_toscana_dir';
---
SELECT DateTime('now'),'command: RL2_SetRasterCoverageInfos - title and abstract text';
SELECT RL2_SetRasterCoverageInfos('dritte_landesaufnahme_toscana_dir','1903-1912 - Dritte Landesaufnahme (Franzisco-Josephinische) Österreich - 1:200000','Area of Toscana - Southern portion of Ravenna missing in original image. 9 Geo-Tiff Images 308 MB');
---
SELECT DateTime('now'),'command: RL2_LoadRastersFromDir : dritte_landesaufnahme_toscana_dir : dritte_landesaufnahme_toscana_dir [] time_run[]';
-- SELECT RL2_LoadRaster('dritte_landesaufnahme_toscana_dir','1811.Neuester_Grundriss_von_Berlin.5800.3068.tif');
--- Error: near line 48: no such function: RL2_LoadRastersFromDir
----> forgot 'export SPATIALITE_SECURITY=relaxed'
SELECT RL2_LoadRastersFromDir
(
 -- chosen name of raster_coverage
 'dritte_landesaufnahme_toscana_dir', 
  -- directory where the files to be loaded are stored
 '../Dritte_Landesaufnahme.Toscana',
 -- file extension of the files in the directory to be loaded
 '.tif'
);
SELECT DateTime('now'),'command: RL2_LoadRastersFromDir : db [30.3.MB] time_run_jpeg[3 min 49 sec]';
-- SELECT SE_RegisterRasterStyledLayer('dritte_landesaufnahme_toscana_dir',XB_Create(XB_LoadXML('../dritte_landesaufnahme_toscana_dir/DIFF1.3_2012_000415_geo_1m.sld'), 1, 1));
------------------
-- 1/9) Importing: ../Dritte_Landesaufnahme.Toscana/1907.29_43_Siena.200000.4805.map.tif
--    Image Size (pixels): 4208 x 4208
--                   SRID: 4805
--       LowerLeft Corner: X=28.50 Y=42.50
--      UpperRight Corner: X=29.50 Y=43.50
--       Pixel resolution: X=0.0002376425855513307 Y=0.0002376425855513307
-- >> Image successfully imported in: 0 mins 10 secs
------------------
-- 2/9) Importing: ../Dritte_Landesaufnahme.Toscana/1903.27_44_Genua.200000.4805.map.tif
--    Image Size (pixels): 4191 x 4191
--                   SRID: 4805
--       LowerLeft Corner: X=26.50 Y=43.50
--      UpperRight Corner: X=27.50 Y=44.50
--       Pixel resolution: X=0.0002386065378191362 Y=0.0002386065378191362
----
-- Note: returns with rc=1, with no furter attempt to import images 2-9
--- cause of failure: different Pixel-Resolution
--- use  mixed_resolutions=1: runs correctly, but no RL2_PyramidizeMonolithic
----
SELECT DateTime('now'),'command: RL2_Pyramidize';
-- SELECT RL2_Pyramidize('dritte_landesaufnahme_toscana_dir','1811.Selter_Grundriss_von_Berlin.5800.3068',0,0);
SELECT RL2_Pyramidize('dritte_landesaufnahme_toscana_dir');
----
-- SELECT DateTime('now'),'command: RL2_PyramidizeMonolithic : dritte_landesaufnahme_toscana_dir';
-- SELECT RL2_PyramidizeMonolithic('dritte_landesaufnahme_toscana_dir');
--> MixedResolutions forbids a Monolithic Pyramid on "dritte_landesaufnahme_toscana_dir"
---> use RL2_Pyramidize
SELECT DateTime('now'),'command(s): SE_UpdateRasterCoverageExtent/SE_UpdateVectorCoverageExtent';
-- the DB "dritte_landesaufnahme_toscana_dir.db" doesn't contain any valid Raster or Vector Coverage
--> cause: missing SE_UpdateRasterCoverageExtent/SE_UpdateVectorCoverageExtent
SELECT SE_UpdateRasterCoverageExtent(1);
-- SELECT SE_UpdateVectorCoverageExtent(1);
-- VACUUM;
SELECT DateTime('now'),'createrasters_fromdir.rl2_Dritte_Landesaufnahme.Toscana [finished] [Habe fertig!]';
