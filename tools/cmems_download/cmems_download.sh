#!/bin/bash
set -euo pipefail

DATASET_ID="med-cmcc-tem-rean-d"
VARIABLE="thetao"
MIN_LAT="${1}"
MAX_LAT="${2}"
MIN_LON="${3}"
MAX_LON="${4}"
DEPTH_MIN="${5}"
DEPTH_MAX="${6}"
START_DATE="${7}"
END_DATE="${8}"
OUTPUT_FILE="${9}"
OUTPUT_FILE="$(echo "$OUTPUT_FILE" | xargs)"
echo "Output file: '$OUTPUT_FILE'"

cm_xmin=`echo " ${MIN_LON} - 0.1" | bc`
cm_ymin=`echo " ${MIN_LAT} - 0.1" | bc`
cm_xmax=`echo " ${MAX_LON} + 0.1" | bc`
cm_ymax=`echo " ${MAX_LAT} + 0.1" | bc`

TMP_FILE="${OUTPUT_FILE}.nc"

copernicusmarine subset \
	    --dataset-id "$DATASET_ID" \
	    --variable "$VARIABLE" \
	    --minimum-latitude "${cm_ymin}" \
	    --maximum-latitude "${cm_ymax}" \
	    --minimum-longitude "${cm_xmin}" \
	    --maximum-longitude "${cm_xmax}" \
	    --minimum-depth "$DEPTH_MIN" \
	    --maximum-depth "$DEPTH_MAX" \
	    --start-datetime "$START_DATE" \
	    --end-datetime "$END_DATE" \
	    --output-filename "$TMP_FILE" \
	    --overwrite

mv "$TMP_FILE" "$OUTPUT_FILE"

