#!/bin/bash

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
        echo "Unknown value or unsupported for _DAPPNODE_GLOBAL_CONSENSUS_CLIENT_MAINNET Please confirm that the value is correct"
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
        echo "Unknown value or unsupported for _DAPPNODE_GLOBAL_CONSENSUS_CLIENT_HOLESKY Please confirm that the value is correct"
        exit 1
        ;;
    esac

    ;;
*)
    echo "Unknown value or unsupported for NETWORK Please confirm that the value is correct"
    exit 1
    ;;
esac

export LIDODVEXIT_BEACON_NODE_URL=${_BEACON_NODE_API}

echo "[INFO] Starting Lido DV Exit..."
exec /usr/local/bin/lido-dv-exit run
