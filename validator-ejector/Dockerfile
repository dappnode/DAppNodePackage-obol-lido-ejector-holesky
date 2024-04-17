ARG VALIDATOR_EJECTOR_VERSION
ARG NETWORK

FROM lidofinance/validator-ejector:${VALIDATOR_EJECTOR_VERSION}
ARG NETWORK

USER root

RUN apk update && apk add inotify-tools

ENV RUN_METRICS=true \
    HTTP_PORT=8989 \
    DISABLE_SECURITY_DONT_USE_IN_PRODUCTION=false \
    NETWORK=${NETWORK} \
    STAKING_MODULE_ID=2 \
    ORACLE_LIST_FILE_PATH=/allowedOracles.json \
    ORACLE_LIST_RETRIEVER_PATH=/app/dist/getOracleAddresses.js

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY getOracleAddresses.js /app/dist/

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]