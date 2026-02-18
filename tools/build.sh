#!/bin/bash
# Required env variables:
# SDK: Path to SDK root
#
# Optional env variables:
# SLC: Path to SLC-CLI binary (default: slc)
# COMMANDER: Path to Simplicity Commander binary (default: commander)

set -euo pipefail

if [ -z "${SDK}" ]; then
	echo "ERROR: env variable SDK must be set to SDK root"
	exit 1
fi

SLC=${SLC:-slc}
COMMANDER=${COMMANDER:-commander}
PROJ_NAME=nc_controller_ncp

rm -rf build/

# Trust SDK and extension signatures
$SLC signature trust --sdk "$SDK"
$SLC signature trust -extpath "$(pwd)/extension"

# Find the ARM toolchain if not set
if [ -z "${TOOLCHAIN:-}" ]; then
	TOOLCHAIN=$(find "$HOME/.silabs/slt/installs/conan/p" -maxdepth 1 -name "gcc-*" -type d | head -n 1)/p
	echo "Found toolchain: $TOOLCHAIN"
fi

# Generate project with CMake output, copying all sources
$SLC generate \
	"$PROJ_NAME.slcp" \
	-d build/ \
	--sdk "$SDK" \
	--copy-sources \
	--toolchain gcc \
	--output-type vscode

# Build with CMake + Ninja
cd build/cmake_gcc
cmake -G Ninja \
	-D CMAKE_TOOLCHAIN_FILE=toolchain.cmake \
	-D post_build_command="$(which $COMMANDER)" \
	.
ARM_GCC_DIR="$TOOLCHAIN" cmake --build .
