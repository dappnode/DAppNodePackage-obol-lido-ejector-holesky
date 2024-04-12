ARG LIDO_DV_EXIT_VERSION
ARG NETWORK

FROM obolnetwork/lido-dv-exit:${LIDO_DV_EXIT_VERSION}
ARG NETWORK

ENV NETWORK=${NETWORK}

USER root

RUN mkdir -p /opt/charon/.charon

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]