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
types=""
object=""
while IFS= read -r line
do
  if [[ $line =~ $regex ]]
    then
      # Set ios xcconfig and plist
      key=${BASH_REMATCH[1]}
      value=${BASH_REMATCH[2]}
      # Put the value on common xcconfig
      if grep -q "${key}=" "${SRCROOT}/Config.xcconfig";
        then
          sed -i '' -e "s/${key}=.*/${key}=${value//\//\/}/g" "${SRCROOT}/Config.xcconfig"
        else
          echo "${key}=${value}" >> "${SRCROOT}/Config.xcconfig"
      fi
      # Put the value on info.plist
      /usr/libexec/PlistBuddy -c "Add ENV_VAR_${key} string \$\{${key}\}" "${SRCROOT}/${INFOPLIST_FILE}"
      # Put the value on JS json
      if test $first -eq 0;
        then
          object="${object},\n"
        else
          first=0
      fi
      types="${types}${key}:string\n"
      object="${object}${key}:'${value}'"

  else
    echo "$line doesn't match the correct pattern" # this could get noisy if there are a lot of non-matching files
  fi

done < $1
js="export type configType = {\n${types}}\n\nconst config: configType = {\n${object}}\n\nexport default config"
echo "writing to ${SRCROOT}/../node_modules/react-native-environmental/env.ts"
echo $js > "${SRCROOT}/../node_modules/react-native-environmental/env.ts"
