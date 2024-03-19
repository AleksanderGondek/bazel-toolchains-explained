#!/bin/sh

# This script is a mock 'compiler' of iron language.
# It's purpose is to 'transform' a singular *.fe file into an binary application
# that displays text stored in said .fe file.
#
# The script must be executed as follows:
# $ iron-compile.sh
#   <path-to=iron.cpp.template>
#   <path-to-fe-file>
#   <path-to-desired-output>
#   <optional-meta-info-denoting-exec-arch>
#   <optional-meta-info-denoting-exec-os>
#   <optional-meta-info-denoting-target-arch>
#   <optional-meta-info-denoting-target-os>

SOURCE_TEMPLATE_PATH="$1"
FE_FILE_PATH="$2"
OUTPUT_FILE_PATH="$3"

EXEC_ARCH="${4:-'N/A'}"
EXEC_OS="${5:-'N/A'}"
TARGET_ARCH="${6:-'N/A'}"
TARGET_OS="${7:-'N/A'}"

# Read FE_FILE contents into variable
FE_FILE_CONTENTS=$(cat "${FE_FILE_PATH}")

# Create source cpp file for the application
## Copy over the template .cpp
SOURCE_FILE_NAME=$(basename ${FE_FILE_PATH})
cp -f "${SOURCE_TEMPLATE_PATH}" ./"${SOURCE_FILE_NAME}"
## Replace variables in template with actual values
sed -i "s#{{EXEC_ARCH}}#${EXEC_ARCH}#" ./"${SOURCE_FILE_NAME}"
sed -i "s#{{EXEC_OS}}#${EXEC_OS}#" ./"${SOURCE_FILE_NAME}"
sed -i "s#{{TARGET_ARCH}}#${TARGET_ARCH}#" ./"${SOURCE_FILE_NAME}"
sed -i "s#{{TARGET_OS}}#${TARGET_OS}#" ./"${SOURCE_FILE_NAME}"
sed -i "s#{{FE_FILE_CONTENTS}}#${FE_FILE_CONTENTS}#" ./"${SOURCE_FILE_NAME}"

# Compile the iron language application
gcc --std=c++20 -lstdc++ "${SOURCE_FILE_PATH}" -o "${OUTPUT_FILE_PATH}"
