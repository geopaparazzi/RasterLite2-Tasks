-- paths must be relative to where the original sql-script was called from
-- create a spatialite database, with InitSpatialMetadata(1)
-- create a rasterlit2 database, with CreateRasterCoverages,Styling Table and UpdateExtent
.read ../../common/source_sql/update.rasterlite2_coverageextent.sql
