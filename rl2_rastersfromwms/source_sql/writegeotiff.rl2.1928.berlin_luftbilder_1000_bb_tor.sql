---
SELECT DateTime('now'),'writegeotiff.1928.berlin_luftbilder_1000_bb_tor.sql [begin]';
-- export "SPATIALITE_SECURITY=relaxed"
-- sqlite3 2010.berlin_k5.db < RL2_WriteGeoTiff.Spandau_1928.sql
-- sqlite3 1926.berlin_k4.db < RL2_WriteGeoTiff.Spandau_1928.sql
-- sqlite3 1910.berlin_data.db < RL2_WriteGeoTiff.Spandau_1928.sql
-- sqlite3 1926.berlin_eiskeller.db < RL2_WriteGeoTiff.Eiskeller_1928.sql
---
SELECT load_extension('/usr/local/lib/mod_rasterlite2');
SELECT load_extension('/usr/local/lib/mod_spatialite');
---
SELECT DateTime('now'),'command: RL2_WriteGeoTiff : 1928.berlin_luftbilder_1000_bb_tor : 1928.berlin_luftbilder_1000_bb_tor.3068.tif';
---
SELECT RL2_WriteGeoTiff
(
 -- raster_coverage
 '1928.berlin_luftbilder_1000_bb_tor', 
 -- file-name with path
 '../berlin_images/1928.berlin_luftbilder_1000_bb_tor.3068.tif', 
 -- image-width based on extent of polygon and base-resolution
 (
  CastToInteger
  (
   (
    ST_MaxX(ST_Envelope(MakeCircle(23180.811529435785,21046.90882931085,(1000/2),3068)))-
    ST_MinX(ST_Envelope(MakeCircle(23180.811529435785,21046.90882931085,(1000/2),3068)))
   )/0.280053796298
  )
 ),
 -- image-height based on extent of polygon and base-resolution
 (
  CastToInteger
  (
   (
    ST_MaxY(ST_Envelope(MakeCircle(23180.811529435785,21046.90882931085,(1000/2),3068)))-
    ST_MinY(ST_Envelope(MakeCircle(23180.811529435785,21046.90882931085,(1000/2),3068)))
   )/0.280053796298
  )
 ), 
 --- 1000 Meters around the Brandenburg Gate
 ST_Envelope(MakeCircle(23180.811529435785,21046.90882931085,(1000/2),3068)),
 -- use base-resolution
 0.280053796298,0.280053796298, 
 -- no world-file
 0, 
 -- compression
 'JPEG',
 -- tile_size [Block=128x128]
 128
);
---
SELECT DateTime('now'),'writegeotiff.1928.berlin_luftbilder_1000_bb_tor.sql [finished] [Habe fertig!]';
---


