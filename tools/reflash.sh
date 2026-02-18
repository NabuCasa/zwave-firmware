#!/bin/bash

#
# Erases a Z-Wave board, flashes a new bootloader, application and keys
#

# Modify the following to match your configuration and folder structure

# This is the serial no. of your J-Link:
SERIAL=852006482
# This is where the commander executable is located
COMMANDER=~/SimplicityStudio_v5/developer/adapter_packs/commander/commander

# This is where the encryption and signing keys are located
# KEYS=nc_firmware/keys
# These are the images (bootloader and application) that should be flashed
# BTL=build/release/nc_controller_bootloader_otw.hex
APP=build/release/nc_controller_ncp.hex
# APP=nc_firmware/zniffer/nc_controller_zniffer.hex
# APP=nc_firmware/repeater/nc_controller_soc_repeater.hex


# Do not change
DEVICE=EFR32ZG23A020F512GM40

# $COMMANDER device masserase -s $SERIAL -d $DEVICE
# $COMMANDER flash $BTL --address 0x0 -s $SERIAL -d $DEVICE
$COMMANDER flash $APP --address 0x0 -s $SERIAL -d $DEVICE
# $COMMANDER flash --tokengroup znet --tokenfile "$KEYS/vendor_encrypt.key" --tokenfile "$KEYS/vendor_sign.key-tokens.txt" -s $SERIAL -d $DEVICE
