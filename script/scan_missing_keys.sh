#!/bin/bash

REPO_PATH="/home/rachana/buildkite/docker-buildkite"

#searching for if any file contains Acess_Key
echo "searching if any files contain acess_key"
for file in *
do
   echo `grep -il "access_key" $file`
done



