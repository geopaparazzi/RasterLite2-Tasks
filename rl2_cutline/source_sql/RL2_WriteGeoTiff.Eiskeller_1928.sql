-- sqlite3 ../db/1926.berlin_eiskeller.db < ../sql/RL2_WriteGeoTiff.Eiskeller_1928.sql
.read ../../common/source_sql/create.rasterlite2_db.sql

SELECT DateTime('now'),'create.rl2.1926.berlin_eiskeller.sql [begin] ';
----
--  COMPRESSION=CCITTFAX4
--  INTERLEAVE=BAND
--  MINISWHITE=YES
-- Band 1 Block=512x512 Type=Byte, ColorInterp=Palette
--  Image Structure Metadata:
--    NBITS=1
--  Color Table (RGB with 2 entries)
--    0: 255,255,255,255
--    1: 0,0,0,255
----
-- gdal_translate -co PHOTOMETRIC=MINISWHITE -co NBITS=1 -co COMPRESS=CCITTFAX4 -co TILED=yes -co BLOCKXSIZE=512 -co BLOCKYSIZE=512 
----
-- rl2tool CREATE -db 423C_42348MINISWHITE.sqlite -cov 423C_42348 \
-- -smp 1-BIT -pxl MONOCHROME -cpr FAX4 -srid 3068 \
-- -res 0.211668210080700
--- gdalwarp -s_srs epsg:3068 -t_srs epsg:3068 -te 6000.0 27100.0 8800 31000.0 1926.berlin.4000.3068.k4.tif 1926.berlin_eiskeller.4000.3068.tif
SELECT DateTime('now'),'command: RL2_CreateRasterCoverage : 1926.berlin_eiskeller - Size 4567, 6362';
-- SELECT RL2_CreateRasterCoverage('1926.berlin_eiskeller','UINT8','RGB',3,'JPEG',80,512,512,3068,0.613093934749288,0.613014775227916);
-- SELECT RL2_CreateRasterCoverage('1750.berlin_schmettau','UINT8','RGB',3,'JPEG',80,512,512,3068,0.538783180039355);
-- SELECT RL2_CreateRasterCoverage('1926.berlin_k4','UINT8','RGB',3,'JPEG',80,512,512,3068,0.613026819923372);
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
SELECT RL2_LoadRaster('1926.berlin_eiskeller','../berlin_images/1926.berlin_eiskeller.4000.3068.tif',0,3068,0,1);
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
