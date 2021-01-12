#!/bin/sh

#  EnvCopyFinish.sh
#  multienv
#
#  Created by Javier Bustamante on 01/01/2020.
#  Copyright © 2020 Facebook. All rights reserved.

# Recover inicital values
echo "--------> Recover initial values"
cp "${SRCROOT}/${INFOPLIST_FILE}_prebuildenv_backup" "${SRCROOT}/${INFOPLIST_FILE}"
cp "${SRCROOT}/Config.xcconfig_prebuildenv_backup" "${SRCROOT}/Config.xcconfig"
rm "${SRCROOT}/${INFOPLIST_FILE}_prebuildenv_backup"
rm "${SRCROOT}/Config.xcconfig_prebuildenv_backup"
