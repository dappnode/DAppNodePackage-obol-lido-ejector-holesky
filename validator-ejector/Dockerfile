ARG VALIDATOR_EJECTOR_VERSION
ARG NETWORK

FROM lidofinance/validator-ejector:${VALIDATOR_EJECTOR_VERSION}

ENV RUN_METRICS=true \
    HTTP_PORT=8989 \
    DISABLE_SECURITY_DONT_USE_IN_PRODUCTION=false \
    NETWORK=${NETWORK}

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]