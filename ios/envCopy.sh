#!/bin/sh

#  envCopy.sh
#  multienv
#
#  Created by Javier Bustamante on 01/01/2020.
#  Copyright © 2020 Facebook. All rights reserved.

echo "Building enviroment files for $1 environment"

# Backup the plist and the xcconfig files
cp "${SRCROOT}/${INFOPLIST_FILE}" "${SRCROOT}/${INFOPLIST_FILE}_prebuildenv_backup"
cp "${SRCROOT}/Config.xcconfig" "${SRCROOT}/Config.xcconfig_prebuildenv_backup"

inputmain="${SRCROOT}/../.env"
inputspecific="$inputmain.$1"

if [ -f "${inputspecific}" ]; then
    echo "Extracting from file ${inputspecific}"
    echo "${SRCROOT}/../node_modules/react-native-environmental/ios/envCopyAux.sh"
    . "${SRCROOT}/../node_modules/react-native-environmental/ios/envCopyAux.sh" "${inputspecific}"
else
    if [ -f "${inputmain}" ]; then
        echo "Extracting from file ${inputspecific}"
        . "${SRCROOT}/../node_modules/react-native-environmental/ios/envCopyAux.sh" "${inputmain}"
    else
        echo "You don't have any .env or .env.$1 file"
    fi
fi
