#"/bin/bash
# ./rl2_create_2010_berlin_k5_schmettau_db.sh
#  wmslite --ip-port 8081 -db ../source_db/2010.berlin_k5_schmettau.db &
# LibreWMS &
#---------------------------------------------------
# Adapt db/sql diretory path where needed
#---------------------------------------------------
IMAGE_DIR="../../common/berlin_images";
DB_DIR="../source_db";
SQL_DIR="../source_sql";
#---------------------------------------------------
# Adapt db/sql file name where needed
#---------------------------------------------------
IMAGE_BASE="2010.berlin_k5_schmettau";
#---------------------------------------------------
# no more changes should be needed
#---------------------------------------------------
DB_FILE="${IMAGE_BASE}.db";
SQL_FILE="create.rl2.${IMAGE_BASE}.sql";
IMAGE_FILE="${IMAGE_BASE}.5000.3068.tif";
# IMAGE_FILE="${IMAGE_FILE}.4000.3068.info.txt";
CMD_SQLITE3=`which sqlite3`;
exit_rc=0;
export "SPATIALITE_SECURITY=relaxed"
DB_PATH="${DB_DIR}/${DB_FILE}";
SQL_PATH="${SQL_DIR}/${SQL_FILE}";
IMAGE_PATH="${IMAGE_DIR}/${IMAGE_FILE}";
#---------------------------------------------------
if [ ! -f "${IMAGE_PATH}" ]
then
 exit_rc=1;
 #---------------------------------------------------
 WWW_BERLIN_IMAGES="http://www.mj10777.de/rasterlite2/build_berlin_data/berlin_images";
 WWW_PATH="${WWW_BERLIN_IMAGES}/${IMAGE_FILE}";
 CMD_WGET=`which wget`;
 # copyright protected, not on server
 CMD_WGET="";
 if [ ! -z "${CMD_WGET}" ]
 then 
  echo "-I-> downloading needed 25.3 MB Image-File[${IMAGE_PATH}]";
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
