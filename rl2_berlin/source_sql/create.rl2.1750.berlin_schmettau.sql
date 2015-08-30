SELECT DateTime('now'),'create.rl2.1750.berlin_schmettau.sql [begin] ';
.read ../source_sql/create.database.sql
----
SELECT DateTime('now'),'command: RL2_CreateRasterCoverage : 1750.berlin_schmettau - Size 8719, 9679';
SELECT RL2_CreateRasterCoverage
(
-- chosen name of raster_coverage
 '1750.berlin_schmettau', 
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
 -- Resolution / Pixel size.x/y  (horizontal/vertical)
 0.538783180039355 
);
SELECT DateTime('now'),'command: replacing the default nodata_pixel value of "#FFFFFF" to "#C0C0C0"';
UPDATE raster_coverages SET nodata_pixel = RL2_SetPixelValue(nodata_pixel,0,192) WHERE coverage_name = '1750.berlin_schmettau';
UPDATE raster_coverages SET nodata_pixel = RL2_SetPixelValue(nodata_pixel,1,192) WHERE coverage_name = '1750.berlin_schmettau';
UPDATE raster_coverages SET nodata_pixel = RL2_SetPixelValue(nodata_pixel,2,192) WHERE coverage_name = '1750.berlin_schmettau';
---
SELECT DateTime('now'),'command: RL2_SetRasterCoverageInfos - title and abstract text';
SELECT RL2_SetRasterCoverageInfos
(
 '1750.berlin_schmettau','1750 Stadtplan von Berlin, Schmettau - 1:4333 - Schwarz-Weiß',
 'Der Plan wurde nach einer um 1747 abgeschlossenen Neuvermessung Berlins angefertigt und wird als äußerst zuverlässige Quelle angesehen. Der Titel ist in einer sehr kunstvollen Allegorie des Kupferstechers Georg Friedrich Schmidt im linken unteren Blatt eingefasst. Die Karte selbst ist hingegen laut Jacoby von Friedrich Gottlieb Berger gestochen. Bei diesem Exemplar handelt es sich um eine 1750 korrigierte Version der ursprünglichen Ausgabe von 1748; lediglich zu erkennen an verschiedentlichen überklebten Stellen. Korrigiert wurden: Das Octagon (vor dem Potsdamer Tor ist der Friedrichstädtische Kirchhof hinzugekommen). Das Prinz Heinrich Palais, mit korrekte Position. Umgebung des Invalidenhauses (Gärten nachgetragen). Die Gegend zwischen den Bastionen 12 und 13 die (Alte) Friedrichsbrücke (später auch Herkulesbrücke genannt). Gebiet der Bollwerke 6 und 7 bei Neukölln am Wasser.'
);
---
SELECT DateTime('now'),'command: RL2_LoadRaster : 1750.berlin_schmettau : 1750.Berlin_Plan_de_la_ville_Schmettau.4333.3068.tif [100.6 MB] time_run[]';
SELECT RL2_LoadRaster
(
 -- chosen name of raster_coverage
 '1750.berlin_schmettau', 
 -- path to file to be loaded
 '../berlin_images/1750.Berlin_Plan_de_la_ville_Schmettau.4333.3068.tif' 
);
SELECT DateTime('now'),'command: RL2_LoadRaster : 1750.berlin_schmettau.db [20.6.MB] time_run_jpeg[1 min 59 sec]';
----
--        Image Size (pixels): 12686 x 13970
--                   SRID: 3068
--       LowerLeft Corner: X=21778.45 Y=17061.82
--     UpperRight Corner: X=28613.45 Y=24588.62
--       Pixel resolution: X=0.5387831800393544 Y=0.5387831800393545
-- Image successfully imported in: 4 mins 41 secs
----
--- SELECT DateTime('now'),'command: RL2_Pyramidize';
--- SELECT RL2_Pyramidize('1750.berlin_schmettau','1750.berlin_schmettau.35555.3068.tif',0,0);
----
SELECT DateTime('now'),'command: RL2_PyramidizeMonolithic : 1750.berlin_schmettau';
SELECT RL2_PyramidizeMonolithic('1750.berlin_schmettau');
SELECT DateTime('now'),'create.rl2.1750.berlin_schmettau.sql [finished] [Habe fertig!]';
