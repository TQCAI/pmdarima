#!/bin/bash

output_file=$1

# Check our VERSION. Basically, if it contains letters, it is a pre-release. Otherwise,
# it has to match X.Y or X.Y.Z
#
# --skip means skip existing (can be a little confusing)
if [[ $(cat ${BUILD_SOURCESDIRECTORY}/pmdarima/VERSION) =~ ^[0-9]+\.[0-9]+\.?[0-9]*[a-zA-Z]+[0-9]*$ ]]; then
  # Adding the `test` label means it doesn't show up unless you specifically
  # search for packages with the label `test`
  echo 'Uploading to conda with test label'
  anaconda upload --label test --skip $output_file
elif [[ $(cat ${BUILD_SOURCESDIRECTORY}/pmdarima/VERSION) =~ ^[0-9]+\.[0-9]+\.?[0-9]*$ ]]; then
  echo 'Uploading to production conda channel'
  anaconda upload --skip $output_file
else
  echo "Malformed tag: $(cat ${BUILD_SOURCESDIRECTORY}/pmdarima/VERSION)"
  exit 1
fi