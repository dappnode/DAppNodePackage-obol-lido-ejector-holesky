#!/bin/bash

if [ -z "$CHARON_TO_EXIT_NUMBER" ] || ! [[ "$CHARON_TO_EXIT_NUMBER" =~ ^[0-9]+$ ]]; then
    echo "[ERROR] CHARON_TO_EXIT_NUMBER is not defined or is not a number. Please set the correct value in the config tab."
    exit 0
fi

export LIDODVEXIT_CHARON_RUNTIME_DIR=/charon/charon${CHARON_TO_EXIT_NUMBER} \
    LIDODVEXIT_EJECTOR_EXIT_PATH=/exitmessages/charon${CHARON_TO_EXIT_NUMBER}

if [ -z "$LIDODVEXIT_CHARON_RUNTIME_DIR" ] || [ ! -d "$LIDODVEXIT_CHARON_RUNTIME_DIR" ]; then
    echo "[ERROR] Charon directory is empty or does not exist. Please upload the Obol backup to this package."
    sleep 1h
    exit 0
fi

echo "[INFO] Loading ${NETWORK} settings..."

case $NETWORK in
"mainnet")
    export LIDODVEXIT_EXIT_EPOCH=194048

    case "$_DAPPNODE_GLOBAL_CONSENSUS_CLIENT_MAINNET" in
    "prysm.dnp.dappnode.eth")
        _BEACON_NODE_API="http://beacon-chain.prysm.dappnode:3500"
        ;;
    "teku.dnp.dappnode.eth")
        _BEACON_NODE_API="http://beacon-chain.teku.dappnode:3500"
        ;;
    "lighthouse.dnp.dappnode.eth")
        _BEACON_NODE_API="http://beacon-chain.lighthouse.dappnode:3500"
        ;;
    "nimbus.dnp.dappnode.eth")
        _BEACON_NODE_API="http://beacon-validator.nimbus.dappnode:4500"
        ;;
    "lodestar.dnp.dappnode.eth")
        _BEACON_NODE_API="http://beacon-chain.lodestar.dappnode:3500"
        ;;
    *)
        echo "[ERROR] Unknown value or unsupported for _DAPPNODE_GLOBAL_CONSENSUS_CLIENT_MAINNET Please confirm that the value is correct"
        exit 1
        ;;
    esac

    ;;
"holesky")
    export LIDODVEXIT_EXIT_EPOCH=256

    case "$_DAPPNODE_GLOBAL_CONSENSUS_CLIENT_HOLESKY" in
    "prysm-holesky.dnp.dappnode.eth")
        _BEACON_NODE_API="http://beacon-chain.prysm-holesky.dappnode:3500"
        ;;
    "teku-holesky.dnp.dappnode.eth")
        _BEACON_NODE_API="http://beacon-chain.teku-holesky.dappnode:3500"
        ;;
    "lighthouse-holesky.dnp.dappnode.eth")
        _BEACON_NODE_API="http://beacon-chain.lighthouse-holesky.dappnode:3500"
        ;;
    "nimbus-holesky.dnp.dappnode.eth")
        _BEACON_NODE_API="http://beacon-validator.nimbus-holesky.dappnode:4500"
        ;;
    "lodestar-holesky.dnp.dappnode.eth")
        _BEACON_NODE_API="http://beacon-chain.lodestar-holesky.dappnode:3500"
        ;;
    *)
        echo "[ERROR] Unknown value or unsupported for _DAPPNODE_GLOBAL_CONSENSUS_CLIENT_HOLESKY Please confirm that the value is correct"
        exit 1
        ;;
    esac

    ;;
*)
    echo "[ERROR] Unknown value or unsupported for NETWORK Please confirm that the value is correct"
    exit 1
    ;;
esac

export LIDODVEXIT_BEACON_NODE_URL=${_BEACON_NODE_API}

echo "[INFO] Starting Lido DV Exit..."
exec /usr/local/bin/lido-dv-exit run
