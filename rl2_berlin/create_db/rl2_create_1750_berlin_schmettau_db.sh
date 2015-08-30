#"/bin/bash
# ./rl2_create_1750_berlin_schmettau_db.sh
#---------------------------------------------------
# Adapt db/sql diretory path where needed
#---------------------------------------------------
DB_DIR="../source_db";
SQL_DIR="../source_sql";
#---------------------------------------------------
# Adapt db/sql file name where needed
#---------------------------------------------------
DB_FILE="1750.berlin_schmettau.db";
SQL_FILE="create.rl2.1750.berlin_schmettau.sql";
#---------------------------------------------------
# no more changes should be needed
#---------------------------------------------------
CMD_SQLITE3=`which sqlite3`;
export "SPATIALITE_SECURITY=relaxed"
DB_PATH="${DB_DIR}/${DB_FILE}";
SQL_PATH="${SQL_DIR}/${SQL_FILE}";
#---------------------------------------------------
if [ -f "${DB_PATH}" ]
then
 rm ${DB_PATH}
fi
#---------------------------------------------------
${CMD_SQLITE3} ${DB_PATH} < ${SQL_PATH}
exit_rc=$?
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
