#"/bin/bash
# ./rl2_create_dritte_landesaufnahme_toscana_file_db.sh
#---------------------------------------------------
# Adapt db/sql diretory path where needed
#---------------------------------------------------
IMAGE_DIR="../source_image";
DB_DIR="../source_db";
SQL_DIR="../source_sql";
#---------------------------------------------------
# Adapt db/sql file name where needed
#---------------------------------------------------
IMAGE_BASE="1903.dritte_landesaufnahme_toscana";
#---------------------------------------------------
# no more changes should be needed
#---------------------------------------------------
exit_rc=0;
DB_FILE="${IMAGE_BASE}_file.db";
SQL_FILE="create.rl2.${IMAGE_BASE}.sql";
IMAGE_FILE="${IMAGE_BASE}.200000.4805.tif";
# IMAGE_FILE="${IMAGE_FILE}.200000.4805.info.txt";
CMD_SQLITE3=`which sqlite3`;
export "SPATIALITE_SECURITY=relaxed"
DB_PATH="${DB_DIR}/${DB_FILE}";
SQL_PATH="${SQL_DIR}/${SQL_FILE}";
IMAGE_PATH="${IMAGE_DIR}/${IMAGE_FILE}";
#---------------------------------------------------
if [ ! -f "${IMAGE_PATH}" ]
then
 exit_rc=1;
 #---------------------------------------------------
 WWW_BERLIN_IMAGES="http://www.mj10777.de/rasterlite2/build_berlin_data/source_image";
 WWW_PATH="${WWW_BERLIN_IMAGES}/${IMAGE_FILE}";
 CMD_WGET=`which wget`;
 if [ ! -z "${CMD_WGET}" ]
 then 
  echo "-I-> downloading needed 290.1 MB Image-File[${IMAGE_PATH}]";
  ${CMD_WGET} ${WWW_PATH} -O ${IMAGE_PATH}
  exit_rc=$?
  echo "${CMD_WGET} rc=$exit_rc ";
  if [ -f "${IMAGE_PATH}" ]
  then
   exit_rc=0;
  fi
 fi
 #---------------------------------------------------
fi
#---------------------------------------------------
if [ "$exit_rc" -eq "0" ]
then
 if [ -f "${DB_PATH}" ]
 then
  rm ${DB_PATH}
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
