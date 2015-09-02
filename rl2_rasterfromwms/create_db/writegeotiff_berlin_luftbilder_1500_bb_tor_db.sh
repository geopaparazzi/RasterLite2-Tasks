#"/bin/bash
# ./writegeotiff_berlin_luftbilder_1500_bb_tor_db.sh
#---------------------------------------------------
# Adapt db/sql diretory path where needed
#---------------------------------------------------
IMAGE_DIR="../berlin_images";
DB_DIR="../source_db";
SQL_DIR="../source_sql";
#---------------------------------------------------
# Adapt db/sql file name where needed
#---------------------------------------------------
IMAGE_BASE="1928.berlin_luftbilder_1500_bb_tor";
#---------------------------------------------------
# no more changes should be needed
#---------------------------------------------------
exit_rc=0;
DB_FILE="${IMAGE_BASE}.db";
SQL_FILE="writegeotiff.rl2.${IMAGE_BASE}.sql";
IMAGE_FILE="${IMAGE_BASE}.4000.3068.tif";
# IMAGE_FILE="${IMAGE_FILE}.4000.3068.info.txt";
CMD_SQLITE3=`which sqlite3`;
export "SPATIALITE_SECURITY=relaxed"
DB_PATH="${DB_DIR}/${DB_FILE}";
SQL_PATH="${SQL_DIR}/${SQL_FILE}";
IMAGE_PATH="${IMAGE_DIR}/${IMAGE_FILE}";
#---------------------------------------------------
if [ -f "${IMAGE_PATH}" ]
then
 rm ${IMAGE_PATH}
fi
#---------------------------------------------------
if [ "$exit_rc" -eq "0" ]
then
 if [ -f "${DB_PATH}" ]
 then
  exit_rc=1;
 fi
 #---------------------------------------------------
 ${CMD_SQLITE3} ${DB_PATH} < ${SQL_PATH}
 exit_rc=$?
 #---------------------------------------------------
fi
#---------------------------------------------------
BENE="'Tutto bene!'";
BENENO="'No bene!'";
HABE_FERTIG="Ich habe fertig.";
BASE_NAME=`basename $0`;
BASE_NAME_CUT=`basename $0 | cut -d '.' -f1`;
MESSAGE_TYPE="-I->";
#---------------------------------------------------
if [ "$exit_rc" -eq "0" ]
then
 RC_TEXT=$BENE;
else
 RC_TEXT="$BENENO";
 MESSAGE_TYPE="-E->";
fi
echo "${MESSAGE_TYPE} ${BASE_NAME_CUT} rc=$exit_rc [${RC_TEXT}] - ${HABE_FERTIG}";
exit $exit_rc;
#---------------------------------------------------
