#"/bin/bash
# ./rl2_create_dritte_landesaufnahme_toscana_dir_db.sh
#---------------------------------------------------
# Adapt db/sql diretory path where needed
#---------------------------------------------------
IMAGE_DIR="../Dritte_Landesaufnahme.Toscana";
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
DB_FILE="${IMAGE_BASE}_dir.db";
SQL_FILE="createrasters_fromdir.rl2_${IMAGE_BASE}.sql";
# IMAGE_FILE="${IMAGE_FILE}.4000.3068.info.txt";
CMD_SQLITE3=`which sqlite3`;
export "SPATIALITE_SECURITY=relaxed"
DB_PATH="${DB_DIR}/${DB_FILE}";
SQL_PATH="${SQL_DIR}/${SQL_FILE}";
#---------------------------------------------------
if [ ! -d "${IMAGE_DIR}" ]
then
 exit_rc=1;
 #---------------------------------------------------
 echo "-E-> needed directory is missing [${IMAGE_DIR}] rc=$exit_rc";
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
