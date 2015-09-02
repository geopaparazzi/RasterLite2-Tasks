-- export "SPATIALITE_SECURITY=relaxed"
-- sqlite3 2010.berlin_k5_schmettau.db < update_style.sql
SELECT load_extension('/usr/local/lib/mod_rasterlite2');
SELECT load_extension('/usr/local/lib/mod_spatialite');PRAGMA foreign_keys=1;
-- 
SELECT DateTime('now'),'command: SE_ReloadRasterStyle : [rl2se.monochrome_red]';
SELECT SE_ReloadRasterStyle
( 
 -- the style-name to use
 'rl2se.monochrome_red',
 --create the BLOB
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
