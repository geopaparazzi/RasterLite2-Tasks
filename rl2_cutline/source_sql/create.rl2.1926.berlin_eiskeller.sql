-- export "SPATIALITE_SECURITY=relaxed"
-- sqlite3 ../db/1926.berlin_eiskeller.db < ../sql/RL2_WriteGeoTiff.Eiskeller_1928.sql
.read ../source_sql/create.database.sql

--- gdalwarp -s_srs epsg:3068 -t_srs epsg:3068 -te 6000.0 27100.0 8800 31000.0 1926.berlin.4000.3068.k4.tif 1926.berlin_eiskeller.4000.3068.tif
SELECT DateTime('now'),'create.rl2.1926.berlin_eiskeller.sql [begin] ';
---- from gdalinfo:
-- -Pixel Size = (0.613093934749288,-0.613014775227916)
--  NoData Value=119
SELECT DateTime('now'),'command: RL2_CreateRasterCoverage : 1926.berlin_eiskeller - Size 4567, 6362';
-- SELECT RL2_CreateRasterCoverage('1926.berlin_eiskeller','UINT8','RGB',3,'JPEG',80,512,512,3068,0.613093934749288,0.613014775227916);
SELECT RL2_CreateRasterCoverage
(
 -- chosen name of raster_coverage
 '1926.berlin_eiskeller', 
 -- Data-Type of Image
 'UINT8', 
 -- Image-Type of Image
 'RGB', 
 -- Amount of Bands in the Image
 3, 
 -- chosen Compression to be used
 'JPEG', 
 -- quality, only used for JPEG
 80, 
 -- tile-size-x (to be stored in database)
 512, 
 -- tile-size-y (to be stored in database)
 512, 
 -- srid of Image being read
 3068, 
 -- Resolution / Pixel size.x (horizontal)
 0.613093934749288, 
 -- Resolution / Pixel size.y (vertical)
 0.613014775227916 
);
SELECT DateTime('now'),'command: retaining the default nodata_pixel of "#777777"';
UPDATE raster_coverages SET nodata_pixel = RL2_SetPixelValue(nodata_pixel,0,119) WHERE coverage_name = '1926.berlin_eiskeller';
UPDATE raster_coverages SET nodata_pixel = RL2_SetPixelValue(nodata_pixel,1,119) WHERE coverage_name = '1926.berlin_eiskeller';
UPDATE raster_coverages SET nodata_pixel = RL2_SetPixelValue(nodata_pixel,2,119) WHERE coverage_name = '1926.berlin_eiskeller'; 
---
SELECT DateTime('now'),'command: RL2_SetRasterCoverageInfos - title and abstract text';
SELECT RL2_SetRasterCoverageInfos('1926.berlin_eiskeller','1926 Berlin Auschnitte eiskeller 1:4000','2014 HistoMap Berlin, Landeskartenwerk Karte von Berlin 1:4.000 (K4)');
---
SELECT DateTime('now'),'command: RL2_LoadRaster : 1926.berlin_eiskeller : importing (3.7 gb) 1 geotif [150 dpi - 3.7 GB] time_run[442 mins 40 secs]';
-- coverageName String , sourcePath String , withWorldFile Integer , forceSRID Integer , pyramidize Integer, transaction Integer
SELECT RL2_LoadRaster
(
  -- chosen name of raster_coverage
 '1926.berlin_eiskeller',
 -- path to file to be loaded
 '../berlin_images/1926.berlin_eiskeller.4000.3068.tif', 
 -- with_worldfile (0= if geotiff, 1= if worldfile)
 0, 
  -- force srid (mainly needed when using world_files - where the srid is not included)
 3068,
 -- pyramidize
 0, 
 -- transaction
 1 
);
-- SELECT RL2_LoadRaster('1926.berlin_eiskeller','/home/mj10777/000_links/build_berlin_data/berlin_images/1926.berlin_eiskeller.4000.3068.tif',0,3068,0,1)
SELECT DateTime('now'),'command: RL2_LoadRaster : 1926.berlin_eiskeller.db [978.9 MB] time_run[time_run_jpeg[7 hrs 50 min 15 sec]';
----
--    Importing: ../berlin_images/1926.berlin.4000.3068.k4.tif
--    Image Size (pixels): 75690 x 62640
--                   SRID: 3068
--       LowerLeft Corner: X=3200.00 Y=399.85
--      UpperRight Corner: X=49600.00 Y=38800.00
--       Pixel resolution: X=0.6130268199233722 Y=0.6130292225797836
----  Image successfully imported in: 442 mins 40 secs
SELECT DateTime('now'),'command: PyramidizeMonolithic';
-- rl2tool PYRAMIDIZE-MONOLITHIC -db 1926.berlin_eiskeller.db -cov 1926.berlin_eiskeller -lev 1
SELECT RL2_PyramidizeMonolithic('1926.berlin_eiskeller',1,1);
--SELECT RL2_Pyramidize('1926.berlin_eiskeller','1926.berlin_eiskeller.5000.3068',0,0);
----
SELECT DateTime('now'),'create.rl2.1926.berlin_eiskeller.sql [finished] [Habe fertig!]';
-- 0,211668210080700
-- SELECT min(x_resolution_1_1) AS min_res_x,max(x_resolution_1_8) AS max_res_x  FROM "1926.berlin_eiskeller_levels"
-- 0.211668	1733.985977
