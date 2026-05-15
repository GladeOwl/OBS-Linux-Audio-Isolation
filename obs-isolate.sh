#!/bin/bash

DESKTOP_NODE_NAME=""
APP_NODE_NAME=""
OBS_APP_NODE_NAME=""

DESKTOP_NODE=$(pw-dump | jq --arg name "$DESKTOP_NODE_NAME" '.[] | select(.info.props["node.name"] == $name) | .id' | head -1)
APP_NODE=$(pw-dump | jq --arg name "$APP_NODE_NAME" '.[] | select(.info.props["node.name"] == $name) | .id' | head -1)
OBS_APP_NODE=$(pw-dump | jq --arg name "$OBS_APP_NODE_NAME" '.[] | select(.info.props["media.name"] == $name) | .id' | head -1)

if [ -z "$APP_NODE" ] || [ -z "$OBS_APP_NODE" ]; then
    echo "Could not find one or both nodes:"
    echo "  App node: ${APP_NODE:-NOT FOUND}"
    echo "  OBS node: ${OBS_APP_NODE:-NOT FOUND}"
    exit 1
fi

echo "Linking App (node $APP_NODE) -> OBS (node $OBS_APP_NODE)"
pw-link $APP_NODE $OBS_APP_NODE

echo "De-Linking Desktop Audio (node $DESKTOP_NODE) -/> OBS (node $OBS_APP_NODE)"
pw-link -d $DESKTOP_NODE $OBS_APP_NODE