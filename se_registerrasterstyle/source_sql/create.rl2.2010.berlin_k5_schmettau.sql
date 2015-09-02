SELECT DateTime('now'),'create.rl2.2010.berlin_k5_schmettau.sql [begin] ';
---
.read ../source_sql/create.database.sql
---
SELECT DateTime('now'),'command: RL2_CreateRasterCoverage : 2010.berlin_k5_schmettau - Size 35433, 35433';
SELECT RL2_CreateRasterCoverage
(
 -- chosen name of raster_coverage
 '2010.berlin_k5_schmettau',
 -- Data-Type of Image
 '1-bit',
  -- Image-Type of Image
 'MONOCHROME',
 -- Amount of Bands in the Image
 1,
 -- chosen Compression to be used CCITTFAX4
 'FAX4',
 -- quality, only used for JPEG
 0,
 -- tile-size-x (to be stored in database)
 512,
 -- tile-size-y (to be stored in database)
 512,
 -- srid of Image being read
 3068,
 -- Resolution / Pixel size.x (horizontal) and size.y (vertical)
 0.211664585547008
);
SELECT DateTime('now'),'command: retaining the default nodata_pixel of "#FFFFFF"';
---
SELECT DateTime('now'),'command: RL2_SetRasterCoverageInfos - title and abstract text';
SELECT RL2_SetRasterCoverageInfos
(
 -- chosen name of raster_coverage
 '2010.berlin_k5_schmettau',
 -- title [short description]
 '2010 Berlin K5 1:5000, Schnitt 1750 Schmettau',
 -- abstract [long description]
 '2010 Rasterkarte 1:5000 - Senatsverwaltung für Stadtentwicklung und Umwelt'
);
---
SELECT DateTime('now'),'command: RL2_LoadRaster : 2010.berlin_k5_schmettau : importing 1 geotif [600 dpi - 25.3 MB MB] time_run[4 mins 39 secs]';
SELECT RL2_LoadRaster
(
 -- chosen name of raster_coverage
 '2010.berlin_k5_schmettau',
 -- path to file to be loaded
 '../../common/berlin_images/2010.berlin_k5_schmettau.5000.3068.tif'
);
SELECT DateTime('now'),'command: RL2_LoadRaster : 2010.berlin_k5_schmettau.db [120 MB] time_run[4 mins 39 secs]';
----
--    Importing: ../../common/berlin_images/2010.berlin_k5_schmettau.5000.3068.tif
--    Image Size (pixels): 35433 x 35433
--                   SRID: 3068
--       LowerLeft Corner: X=21465.00 Y=17108.09
--      UpperRight Corner: X=28964.91 Y=24608.00
--      Pixel resolution: X=0.211664585547008 Y=0.211664585547008
-- >> Image successfully imported in: 1 mins 07 secs
----
SELECT DateTime('now'),'command: PyramidizeMonolithic';
SELECT DateTime('now'),'command: PyramidizeMonolithic : 2010.berlin_k5_schmettau.db [152 MB] time_run[10 mins 0 secs]';
-- rl2tool PYRAMIDIZE-MONOLITHIC -db 2010.berlin_k5_schmettau.db -cov 2010.berlin_k5_schmettau -lev 1
SELECT RL2_PyramidizeMonolithic('2010.berlin_k5_schmettau',1,1);
--SELECT RL2_Pyramidize('2010.berlin_k5_schmettau','2010.berlin_k5_schmettau.5000.3068',0,0);
---
SELECT DateTime('now'),'command: loading Style ''rl2se.monochrome_red'' ';
SELECT SE_RegisterRasterStyle
( --create the BLOB
 XB_Create
 ( -- load the external xml file
  XB_LoadXML
  ( -- the value of 'Name' will be used as the style_name 'rl2se.monochrome_red'
   '../../common/source_styles/raster/rl2se.monochrome_red.xml'
  ),
  -- compression
  1, 
  -- with validation
  1  
 )
);
SELECT DateTime('now'),'command: register Style to Layer ''rl2se.monochrome_red'' ';
SELECT SE_RegisterRasterStyledLayer
(
 -- chosen name of raster_coverage
 '2010.berlin_k5_schmettau',
 -- the style-name to use
 'rl2se.monochrome_red'
);
---
.read ../source_sql/update.database.sql
---
SELECT DateTime('now'),'create.rl2.2010.berlin_k5_schmettau.sql [finished] [Habe fertig!]';
-- wmslite --ip-port 8081 -db ../source_db/2010.berlin_k5_schmettau.db &
-- Publishing layer "2010.berlin_k5_schmettau"
-- LibreWMS &


