#!/bin/bash

# TODO réécrire en python pour en faire un plugin sublime text

programName=$0
subfolder=$1
moduleName=$2

ERR_CREATE_FOLDER=101
ERR_CREATE_TEMPLATE=102
ERR_CREATE_CONTROLLER=103
ERR_CREATE_COMPONENT=104
ERR_CREATE_MODULE=105

function executeCommand {
  local commandText=$1
  local errCode=$2

  eval $commandText
  local ret=$?
  if [ $ret -ne 0 ]; then
    echo "action failed: $errCode"
    exit ${!errCode}
  fi;
}

function helpText {
  echo "usage: $programName <subfolder> <module name in a camel case>"
}


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

basefolder=$DIR/../src/$subfolder/

if [ -z "$1" -o -z "$2" ]; then
  echo "subfolder and module name are both required"
  helpText
  exit 1;
fi

pascaledModuleName="$(tr '[:lower:]' '[:upper:]' <<< ${moduleName:0:1})${moduleName:1}"
dashedModuleName=`echo $moduleName | sed -e 's/\([A-Z]\)/-\L\1/g' -e 's/^-//'`
folder=$basefolder/$dashedModuleName

echo "creating module <$1> into <$basefolder> with dashed module name <$dashedModuleName>"

echo "create folder $folder"
executeCommand "mkdir $folder" "ERR_CREATE_FOLDER"

echo "create component template"
executeCommand "touch $folder/$dashedModuleName.html" "ERR_CREATE_TEMPLATE"

echo "create component controller"
executeCommand "sed \"s/%moduleName%/$pascaledModuleName/g\" controller.js > $folder/$dashedModuleName.controller.js"  "ERR_CREATE_CONTROLLER"

echo "create component"
executeCommand "sed \"s/%moduleName%/$dashedModuleName/g\" component.js > $folder/$dashedModuleName.component.js"  "ERR_CREATE_COMPONENT"

echo "create module"
executeCommand "sed \"s/%moduleName%/$moduleName/g\" module.js | sed \"s/%dashedModuleName%/$dashedModuleName/g\" > $folder/$dashedModuleName.module.js"  "ERR_CREATE_MODULE"

cd -
