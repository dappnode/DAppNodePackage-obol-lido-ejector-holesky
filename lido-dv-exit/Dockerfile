ARG LIDO_DV_EXIT_VERSION
FROM obolnetwork/lido-dv-exit:${LIDO_DV_EXIT_VERSION}

# TODO: How to avoid sharing volumes with charon?

ENV LIDODVEXIT_CHARON_RUNTIME_DIR=/charon \
    LIDODVEXIT_EJECTOR_EXIT_PATH=/exitmessages \
    NETWORK=holesky

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]