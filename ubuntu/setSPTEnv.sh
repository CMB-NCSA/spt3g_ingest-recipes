#!/usr/bin/env bash

echo "Starting SPT3G environment"
export SPT3G_SOFTWARE_PATH=/opt/spt/spt3g_software
export SPT3G_SOFTWARE_BUILD_PATH=/opt/spt/spt3g_software/build
export SPT3G_BUILD_ROOT=${SPT3G_SOFTWARE_BUILD_PATH}
export PATH=${SPT3G_BUILD_ROOT}/bin:$PATH
export LD_LIBRARY_PATH=${SPT3G_BUILD_ROOT}/spt3g:$LD_LIBRARY_PATH
export PYTHONPATH=${SPT3G_BUILD_ROOT}:$PYTHONPATH

echo "Adding spt3g_ingest"
source /opt/spt/spt3g_ingest/setpath.sh /opt/spt/spt3g_ingest
