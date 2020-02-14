#!/bin/sh

#  envCopyAux.sh
#  multienv
#
#  Created by Javier Bustamante on 01/01/2020.
#  Copyright © 2020 Facebook. All rights reserved.

echo "Extracting properties from $1"

# regex="^\s*(?:export\s+|)([\w\d\\.\-_]+)\s*=\s*['\"]?(.*?)?['\"]?\s*\$"
regex='^[[:blank:]]*([[:alnum:]_\.-]+)[[:blank:]]*=[[:blank:]]*(.+)[[:blank:]]*$'
first=1
json="{"
while IFS= read -r line
do
  if [[ $line =~ $regex ]]
    then
      # Set ios xcconfig and plist
      key=${BASH_REMATCH[1]}
      value=${BASH_REMATCH[2]}
      # Put the value on common xcconfig
      echo "${key}=${value}" >> "${SRCROOT}/Config.xcconfig"
      # Put the value on info.plist
      /usr/libexec/PlistBuddy -c "Add ENV_VAR_${key} string \$\{${key}\}" "${SRCROOT}/${INFOPLIST_FILE}"
      # Put the value on JS json
      if test $first -eq 0;
        then
          json="${json},"
        else
          first=0
      fi
      json="${json}\"${key}\":\"${value}\""
      
  else
    echo "$line doesn't match the correct pattern" # this could get noisy if there are a lot of non-matching files
  fi

done < $1

json="${json}}"
echo writing
echo $json
echo to
echo "${SRCROOT}/../node_modules/react-native-environmental/.env.js"
echo $json > "${SRCROOT}/../node_modules/react-native-environmental/.env.js"
