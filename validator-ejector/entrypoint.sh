#!/bin/sh

# If OPERATOR_ID is not defined or is not a number, exit 0 to avoid restart, telling the user to set the correct value
if [ -z "$OPERATOR_ID" ] || ! echo "$OPERATOR_ID" | grep -qE '^[0-9]+$'; then
      echo "[ERROR] OPERATOR_ID is not defined or is not a number. Please set the correct value in the config tab."
      exit 0
fi

if [ -z "$CHARON_TO_EXIT_NUMBER" ] || ! echo "$CHARON_TO_EXIT_NUMBER" | grep -qE '^[0-9]+$'; then
      echo "[ERROR] CHARON_TO_EXIT_NUMBER is not defined or is not a number. Please set the correct value in the config tab."
      exit 0
fi

EXIT_MESSAGES_ROOT="/exitmessages"
CHARON_ID=charon${CHARON_TO_EXIT_NUMBER}

echo "[INFO] Loading ${NETWORK} settings..."

case $NETWORK in
"mainnet")
      export LOCATOR_ADDRESS=0xC1d0b3DE6792Bf6b4b37EccdcC24e45978Cfd2Eb
      export HASH_CONSENSUS_CONTRACT=0x7FaDB6358950c5fAA66Cb5EB8eE5147De3df355a
      export DEFAULT_ORACLE_ADDRESSES_ALLOWLIST='["0x140Bd8FbDc884f48dA7cb1c09bE8A2fAdfea776E 0xA7410857ABbf75043d61ea54e07D57A6EB6EF186 0x404335BcE530400a5814375E7Ec1FB55fAff3eA2 0x946D3b081ed19173dC83Cd974fC69e1e760B7d78 0x007DE4a5F7bc37E2F26c0cb2E8A95006EE9B89b5 0xEC4BfbAF681eb505B94E4a7849877DC6c600Ca3A 0x61c91ECd902EB56e314bB2D5c5C07785444Ea1c8","0x1Ca0fEC59b86F549e1F1184d97cb47794C8Af58d","0xc79F702202E3A6B0B6310B537E786B9ACAA19BAf"]'

      case $_DAPPNODE_GLOBAL_EXECUTION_CLIENT_MAINNET in
      "geth.dnp.dappnode.eth")
            _EXECUTION_NODE_API="http://geth.dappnode:8545"
            ;;
      "nethermind.public.dappnode.eth")
            _EXECUTION_NODE_API="http://nethermind.public.dappnode:8545"
            ;;
      "besu.public.dappnode.eth")
            _EXECUTION_NODE_API="http://besu.public.dappnode:8545"
            ;;
      "erigon.dnp.dappnode.eth")
            _EXECUTION_NODE_API="http://erigon.dappnode:8545"
            ;;
      *)
            echo "Unknown value or unsupported for _DAPPNODE_GLOBAL_EXECUTION_CLIENT_MAINNET Please confirm that the value is correct"
            exit 1
            ;;
      esac

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

      export LOCATOR_ADDRESS=0x28FAB2059C713A7F9D8c86Db49f9bb0e96Af1ef8
      export HASH_CONSENSUS_CONTRACT=0xe77Cf1A027d7C10Ee6bb7Ede5E922a181FF40E8f
      export DEFAULT_ORACLE_ADDRESSES_ALLOWLIST='["0x12A1D74F8697b9f4F1eEBb0a9d0FB6a751366399","0xD892c09b556b547c80B7d8c8cB8d75bf541B2284","0xf7aE520e99ed3C41180B5E12681d31Aa7302E4e5"]'

      case $_DAPPNODE_GLOBAL_EXECUTION_CLIENT_HOLESKY in
      "holesky-geth.dnp.dappnode.eth")
            _EXECUTION_NODE_API="http://holesky-geth.dappnode:8545"
            ;;
      "holesky-nethermind.dnp.dappnode.eth")
            _EXECUTION_NODE_API="http://holesky-nethermind.dappnode:8545"
            ;;
      "holesky-besu.dnp.dappnode.eth")
            _EXECUTION_NODE_API="http://holesky-besu.dappnode:8545"
            ;;
      "holesky-erigon.dnp.dappnode.eth")
            _EXECUTION_NODE_API="http://holesky-erigon.dappnode:8545"
            ;;
      *)
            echo "Unknown value or unsupported for _DAPPNODE_GLOBAL_EXECUTION_CLIENT_HOLESKY Please confirm that the value is correct"
            exit 1
            ;;
      esac

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
      echo "[ERROR] Unknown value or unsupported for NETWORK Please confirm that the value is correct"
      exit 1
      ;;
esac

echo "$DEFAULT_ORACLE_ADDRESSES_ALLOWLIST" >$ORACLE_LIST_FILE_PATH

export MESSAGES_LOCATION="${EXIT_MESSAGES_ROOT}/${CHARON_ID}"
export EXECUTION_NODE=${_EXECUTION_NODE_API}
export CONSENSUS_NODE=${_BEACON_NODE_API}

# Run the script to retrieve the oracle list from the contract (written to the file $ORACLE_LIST_FILE_PATH)
node ${ORACLE_LIST_RETRIEVER_PATH}

export ORACLE_ADDRESSES_ALLOWLIST=$(cat $ORACLE_LIST_FILE_PATH)

if [ ! -d "$MESSAGES_LOCATION" ]; then
      echo "[INFO] Messages directory does not exist. Waiting until the lido-dv-exit service creates it..."

      inotifywait --event create --include "${CHARON_ID}" ${EXIT_MESSAGES_ROOT}
else
      echo "[INFO] Messages directory exists"
fi

echo "[INFO] Starting the lido-dv-exit service..."
cd /app
exec yarn start
