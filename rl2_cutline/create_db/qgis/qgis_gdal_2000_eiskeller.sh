#"/bin/bash
# ./qgis_ohdm_2000_vectorlayers.sh
# /home/mj10777/000_links/apps_local/qgis_210/bin/qgis &
# Update: 20150408
#--------------------------------------
PROJECT_FILE="";
SCRIPT_PATH="`dirname \"$0\"`";
QGIS_FILE="vector_layers_eiskeller.qgs";
# QGIS_FILE="";
# QGIS_FILE="";
# QGIS_FILE="gdal_5903_mlinestring25d_no_filter.qgs";
# change this as needed
PROJECT_PATH="${SCRIPT_PATH}";
#--------------------------------------
# path where local applications are stored
LINKS_PATH="/home/mj10777/000_links/apps_local";
# using QGIS 2.1.0-master binaries
QGIS_PATH="${LINKS_PATH}/qgis_210";
# using QGIS 2.1.0-master binaries
BIN_PATH="${QGIS_PATH}/bin";
# using QGIS 2.1.0-master libs needed by QGIS 2.1.0-master binaries
LIB_PATH="${QGIS_PATH}/lib";
# using QGIS 2.1.0-master libs needed by QGIS 2.1.0-master binaries
SHARE_PATH="${QGIS_PATH}/share";
# using gdal 2.0.0-vector libs needed by QGIS 2.1.0-master binaries
LIB_PATH="${LIB_PATH};${LINKS_PATH}/gdal_2000_vectorlayers/lib";
# and using other default libs (spatialite, geos, proj4 etc.)
# libraries of localy compiled projects
LIB_PATH="${LIB_PATH};/usr/local/lib";
# default system libraries
LIB_PATH="${LIB_PATH};/usr/lib";
# set export, so that the binarie will use this
export LD_LIBRARY_PATH="${LIB_PATH}";
# using QGIS 2.1.0-master libs needed by QGIS 2.1.0-master binaries
PYTHON_PATH="${SHARE_PATH}/qgis/python";
PYTHON_PATH="${PYTHONPATH}${PYTHON_PATH}";
# export PYTHONPATH="${PYTHON_PATH}";
# echo ${PYTHONPATH};
MESSAGE_TEXT="QGIS 2.1.0-master with gdal 2.0.0-vectorlayers from  apps_local";
#--------------------------------------
# full path of the binary to call
QGIS_BIN="${BIN_PATH}/qgis";
#--------------------------------------
echo -e " script_path[${SCRIPT_PATH}]\n bin[${BIN_PATH}]\n lib[${LIB_PATH}]";
if [ ! -z "${QGIS_FILE}" ]
then
 PROJECT_FILE="${PROJECT_PATH}/${QGIS_FILE}";
 echo -e "Starting with qgis project: using [${MESSAGE_TEXT}]: \n [${PROJECT_FILE}]";
fi
#--------------------------------------
${QGIS_BIN} ${PROJECT_FILE} &
#--------------------------------------
exit 0;
#--------------------------------------

