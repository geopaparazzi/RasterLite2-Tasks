SELECT DateTime('now'),'createfromwms.rl2.1928.berlin_luftbilder_1500_bb_tor.sql [begin] ';
---
.read ../source_sql/create.database.sql
---
SELECT DateTime('now'),'command: RL2_CreateRasterCoverage : 1928.berlin_luftbilder_1500_bb_tor - Size 10607x8292';
SELECT RL2_CreateRasterCoverage
( -- RL2_Types_Data_Image_Compression
-- chosen name of raster_coverage
 '1928.berlin_luftbilder_1500_bb_tor', 
 -- Data-Type of Image
 'UINT8', 
 -- Image-Type of Image
 'GRAYSCALE', 
 -- Amount of Bands in the Image
 1, 
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
 -- Resolution / Pixel size.x/y  (horizontal/vertical)
0.280053796298
);
SELECT DateTime('now'),'command: retaining the default nodata_pixel of "#FF"';
---
SELECT DateTime('now'),'command: RL2_SetRasterCoverageInfos - title and abstract text';
SELECT RL2_SetRasterCoverageInfos('1928.berlin_luftbilder_1500_bb_tor','Berlin Luftbilder 1928, Maßstab 1:4 000 - 500 Meters North, West and East and 1000 meters south the Brandenburg Gate, Berlin (including Potsdamer Platz/Bahnohf)','Senkrechtaufnahmen von Berlin, Fotoblätter ohne Überlappungen im Maßstab 1:4 000 - Senatsverwaltung für Stadtentwicklung und Umwelt Berlin');
--- 2014-11-29 17:12:52
SELECT DateTime('now'),'command: RL2_LoadRasterFromWMS : 1928.berlin_luftbilder_1500_bb_tor : wms/senstadt/k_luftbild1928 [0.1005834105]';
-- <LatLonBoundingBox minx="12.9709" miny="52.3005" maxx="13.8109" maxy="52.6954" />
-- <BoundingBox minx="-4650" miny="-2787" maxx="52542" maxy="40963" SRS="EPSG:3068" />
-- # wget "http://fbinter.stadt-berlin.de/fb/wms/senstadt/k_luftbild1928?service=WMS&request=GetMap&version=1.1.1&layers=0&styles=visual&srs=EPSG:3068&format=image/jpeg&width=4957&height=3718&bbox=22400,20800,23200,21400" -O 1928.423C_42336.0250.k0250.jpg
SELECT RL2_LoadRasterFromWMS
( -- Time needed to complete: 4 minutes (at 5h in the morning)
 -- coverageName = Table-Name
 '1928.berlin_luftbilder_1500_bb_tor', 
 -- sectionName
 --- A NULL sectionName always implies processing the whole Coverage
 '1928.Berlin_Luftbilder.0250.3068',
 -- getMapUrl 
 'http://fbinter.stadt-berlin.de/fb/wms/senstadt/k_luftbild1928',
 --- 1000 Meters around the Brandenburg Gate
 -- ST_Envelope(MakeCircle(23180.811529435785,21046.90882931085,(1000/2),3068)),
 BuildMbr
 ( -- Area 1000 meters wide, 1500 high
  -- 500 meters West of the Brandenburg Gate
  (ST_MinX(ST_Envelope(MakeCircle(23180.811529435785,21046.90882931085,(1000/2),3068)))),
  -- 1000 meters South of the Brandenburg Gate, including Potsdamer Platz/Bahnohf
  (ST_MinY(ST_Envelope(MakeCircle(23180.811529435785,21046.90882931085,(1000/1),3068)))),
  -- 500 meters East of the Brandenburg Gate
  (ST_MaxX(ST_Envelope(MakeCircle(23180.811529435785,21046.90882931085,(1000/2),3068)))),
  -- 500 meters North of the Brandenburg Gate
  (ST_MaxY(ST_Envelope(MakeCircle(23180.811529435785,21046.90882931085,(1000/2),3068)))),
  3068
 ),
 -- wmsVersion 1.3.0 '1.1.1',
 '1.1.1',
 -- wmsLayerName CASTORE_WMS
 '0',
 -- wmsLayerStyle <Name>default</Name>
 'default',
 -- wmsImageFormat 
 'image/jpeg',
 -- wmsHorzPixelResolution
 0.280053796298,
 -- wmsVertPixelResolution
 0.280053796298,
 0,
 0,
 '',
 0
);
-- *800/0,1005834105
SELECT DateTime('now'),'command: RL2_PyramidizeMonolithic : 1928.berlin_luftbilder_1500_bb_tor';
SELECT RL2_PyramidizeMonolithic('1928.berlin_luftbilder_1500_bb_tor');
SELECT SE_UpdateRasterCoverageExtent(1);
SELECT SE_UpdateVectorCoverageExtent(1);
SELECT DateTime('now'),'command: RL2_LoadRaster : 1928.berlin_luftbilder_1500_bb_tor [8.9 GB] time_run_deflate[2 days 9 hrs 52 min 24 sec] - Gesamt';
----
SELECT DateTime('now'),'createfromwms.rl2.1928.berlin_luftbilder_1500_bb_tor.sql [finished] [Habe fertig!]';

