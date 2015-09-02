-- export "SPATIALITE_SECURITY=relaxed"
-- sqlite3 2010.berlin_k5_schmettau.db < update_style.sql
SELECT load_extension('/usr/local/lib/mod_rasterlite2');
SELECT load_extension('/usr/local/lib/mod_spatialite');PRAGMA foreign_keys=1;
-- 
SELECT DateTime('now'),'command: SE_RegisterRasterStyle : [rl2se.DIFF1.3_2012_geo_1m]';
SELECT SE_RegisterRasterStyle
( --create the BLOB
 XB_Create
 ( -- load the external xml file
  XB_LoadXML
  ( -- the value of 'Name' will be used as the style_name 'rl2se.monochrome_red'
   '../../common/source_styles/raster/rl2se.DIFF1.3_2012_geo_1m.xml'
  ),
  -- compression
  1, 
  -- with validation
  1  
 )
);
SELECT DateTime('now'),'command: register Style to Layer ''rl2se.DIFF1.3_2012_geo_1m'' ';
SELECT SE_RegisterRasterStyledLayer
(
 -- chosen name of raster_coverage
 '2010.berlin_k5_schmettau',
 -- the style-name to use
 'rl2se.DIFF1.3_2012_geo_1m'
);

