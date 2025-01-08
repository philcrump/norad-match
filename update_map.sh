#!/usr/bin/env bash

# Example crontab:
#
# 23 */8  * * * /.../update_map.sh
#

source_dir="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)";
cd "$source_dir";

source credentials

OUTPUT_FILENAME="./htdocs/map.json"

tempfile_cookies=$(mktemp)
tempfile_output=$(mktemp)

wget -q --post-data="identity=${USER}&password=${PASSWORD}" --cookies=on --keep-session-cookies --save-cookies="${tempfile_cookies}" 'https://www.space-track.org/ajaxauth/login' -O /dev/null;
if [ $? != 0 ]; then
    rm ${tempfile_output};
    rm ${tempfile_cookies};
    echo " - Login to Spacetrack failed, invalid credentials?";
    exit 1;
fi

wget -q --keep-session-cookies --load-cookies="${tempfile_cookies}" "https://www.space-track.org/basicspacedata/query/class/gp/decay_date/null-val/epoch/%3Enow-30/orderby/norad_cat_id/format/json" -O "${tempfile_output}"
if [ $? != 0 ]; then
    rm ${tempfile_output};
    rm ${tempfile_cookies};
    echo " - Download from Spacetrack failed.";
    exit 1;
fi
rm ${tempfile_cookies};

tempfile_mapoutput=$(mktemp)

# Convert file
cat "${tempfile_output}" | jq 'map( { (.NORAD_CAT_ID|tostring): {'name':.OBJECT_NAME, 'type': .OBJECT_TYPE} } ) | add'> "${tempfile_mapoutput}";
rm ${tempfile_output};

# Compress map
gzip -9 -k "${tempfile_mapoutput}";

mv -f "${tempfile_mapoutput}" "${OUTPUT_FILENAME}";
mv -f "${tempfile_mapoutput}.gz" "${OUTPUT_FILENAME}.gz";
