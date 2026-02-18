#!/bin/bash
# Required env variables:
# COMMANDER: Path to Simplicity Commander binary

COMMANDER=${COMMANDER:-commander}

BUILD_OUTPUT=build/cmake_gcc/nc_controller_ncp.hex
OUTFILE=artifacts/zwa2_controller.gbl
SIGN_KEY=keys/vendor_sign.key
ENC_KEY=keys/vendor_encrypt.key

mkdir -p artifacts

$COMMANDER gbl create $OUTFILE --app $BUILD_OUTPUT --sign $SIGN_KEY --encrypt $ENC_KEY --compress lzma
