#!/bin/sh

#  envCopy.sh
#  multienv
#
#  Created by Javier Bustamante on 01/01/2020.
#  Copyright © 2020 Facebook. All rights reserved.

echo "Building enviroment files for $1 environment"

# Restore or Backup the plist and the xcconfig files
plistfile="${SRCROOT}/${INFOPLIST_FILE}"
configfile="${SRCROOT}/Config.xcconfig"
plistfilebackup="${SRCROOT}/${INFOPLIST_FILE}_prebuildenv_backup"
configfilebackup="${SRCROOT}/Config.xcconfig_prebuildenv_backup"
if [ -f "${plistfilebackup}" ]; then
  cp "${plistfilebackup}" "${plistfile}"
else
  cp "${plistfile}" "${plistfilebackup}"
fi
if [ -f "${configfilebackup}" ]; then
  cp "${configfilebackup}" "${configfile}"
else
  cp "${configfile}" "${configfilebackup}"
fi

# Extract .env data
inputmain="${SRCROOT}/../.env"
inputspecific="$inputmain.$1"
if [ -f "${inputspecific}" ]; then
    echo "Extracting from file ${inputspecific}"
    . "${SRCROOT}/../node_modules/react-native-environmental/ios/envCopyAux.sh" "${inputspecific}"
else
    if [ -f "${inputmain}" ]; then
        echo "Extracting from file ${inputspecific}"
        . "${SRCROOT}/../node_modules/react-native-environmental/ios/envCopyAux.sh" "${inputmain}"
    else
        echo "You don't have any .env or .env.$1 file"
    fi
fi
