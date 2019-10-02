#!/usr/bin/env bash

VERSION=$1
ZIPFILE="${VERSION}.zip"
RELEASE_DIR="Device-Detection-${VERSION#?}" # the directory with "v" removed from the tag
DEVICE_DETECTION_ZIP_URL="https://github.com/51Degrees/Device-Detection/archive/${ZIPFILE}"

echo "Removing existing files"
rm -r $RELEASE_DIR cityhash fiftyonepattern fiftyonetrie data
rm cache.c cache.h threading.c threading.h LICENSE

echo "Version: ${VERSION}";
echo "ZIP File: ${ZIPFILE}"

echo "Downloading release"
curl -L --output $ZIPFILE $DEVICE_DETECTION_ZIP_URL

echo "Unzipping release"
unzip $ZIPFILE

echo "Running 51 Degrees make file"
(cd "${RELEASE_DIR}/go"; make)

echo "Gathering needed files and directories"
mv "${RELEASE_DIR}/LICENSE" .
mv "${RELEASE_DIR}/data" .
mv "${RELEASE_DIR}/go/src"/* .
mv pattern fiftyonepattern
mv trie fiftyonetrie

echo "Renaming packages"
sed -i '' 's/package FiftyOneDegreesPatternV3/package fiftyonepattern/' ./fiftyonepattern/*.go
sed -i '' 's/package FiftyOneDegreesTrieV3/package fiftyonetrie/' ./fiftyonetrie/*.go

echo "Removing release"
rm -r $RELEASE_DIR $ZIPFILE
