#!/bin/bash

DESKTOP_NODE_NAME="alsa_output.pci-0000_2d_00.4.analog-stereo"
ARMA_NODE_NAME="Arma 3"
OBS_ARMA_NODE_NAME="Arma"

DESKTOP_NODE=$(pw-dump | jq --arg name "$DESKTOP_NODE_NAME" '.[] | select(.info.props["node.name"] == $name) | .id' | head -1)
ARMA_NODE=$(pw-dump | jq --arg name "$ARMA_NODE_NAME" '.[] | select(.info.props["node.name"] == $name) | .id' | head -1)
OBS_ARMA_NODE=$(pw-dump | jq --arg name "$OBS_ARMA_NODE_NAME" '.[] | select(.info.props["media.name"] == $name) | .id' | head -1)

if [ -z "$ARMA_NODE" ] || [ -z "$OBS_ARMA_NODE" ]; then
    echo "Could not find one or both nodes:"
    echo "  Arma 3 node: ${ARMA_NODE:-NOT FOUND}"
    echo "  OBS node:    ${OBS_ARMA_NODE:-NOT FOUND}"
    exit 1
fi

echo "Linking Arma 3 (node $ARMA_NODE) -> OBS (node $OBS_ARMA_NODE)"
pw-link $ARMA_NODE $OBS_ARMA_NODE

echo "De-Linking Desktop Audio (node $DESKTOP_NODE) -/> OBS (node $OBS_ARMA_NODE)"
pw-link -d $DESKTOP_NODE $OBS_ARMA_NODE

# Teamspeak (OPTIONAL)
# TEAMSPEAK_NODE_NAME="TeamSpeak 3 Client"
# OBS_TEAMSPEAK_NODE_NAME="Teamspeak"

# TEAMSPEAK_NODE=$(pw-dump | jq --arg name "$TEAMSPEAK_NODE_NAME" '.[] | select(.info.props["node.name"] == $name) | .id' | head -1)
# OBS_TEAMSPEAK_NODE=$(pw-dump | jq --arg name "$OBS_TEAMSPEAK_NODE_NAME" '.[] | select(.info.props["media.name"] == $name) | .id' | head -1)

# if [ -z "$TEAMSPEAK_NODE" ] || [ -z "$OBS_TEAMSPEAK_NODE" ]; then
#     echo "Could not find one or both nodes:"
#     echo "  Teamspeak 3 node: ${TEAMSPEAK_NODE:-NOT FOUND}"
#     echo "  OBS node:    ${OBS_TEAMSPEAK_NODE:-NOT FOUND}"
#     exit 1
# fi

# echo "Linking Arma 3 (node $TEAMSPEAK_NODE) -> OBS (node $OBS_TEAMSPEAK_NODE)"
# pw-link $TEAMSPEAK_NODE $OBS_TEAMSPEAK_NODE

# echo "De-Linking Desktop Audio (node $DESKTOP_NODE) -/> OBS (node $OBS_TEAMSPEAK_NODE)"
# pw-link -d $DESKTOP_NODE $OBS_TEAMSPEAK_NODE