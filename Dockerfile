FROM balenalib/armv7hf-debian:stretch AS src

ENV DEBIAN_FRONTEND="noninteractive" PLEX_PATH=/opt/plex/Application

ARG PLEX_VERSION=1.19.1.2645-ccb6eb67e

RUN apt update && apt install -y wget ca-certificates locales

RUN wget --no-verbose -O /tmp/plex.tar https://downloads.plex.tv/plex-media-server-new/${PLEX_VERSION}/synology/PlexMediaServer-${PLEX_VERSION}-armv7hf.spk \
  && tar -xf /tmp/plex.tar -C /tmp \
  && mkdir -p $PLEX_PATH \
  && tar -xf /tmp/package.tgz -C $PLEX_PATH

RUN mv $PLEX_PATH/Resources/start.sh $PLEX_PATH/

RUN sed -i '2i rm -rf /config/Library/Application\\ Support/Plex\\ Media\\ Server/plexmediaserver.pid' $PLEX_PATH/start.sh

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen && locale-gen

FROM arm32v7/debian:stretch-slim

ENV PLEX_PATH=/opt/plex/Application

COPY --from=src ${PLEX_PATH} ${PLEX_PATH}
COPY --from=src /usr/lib/locale /usr/lib/locale

VOLUME ["/config", "/data"]

ENV HOME=/config

WORKDIR ${PLEX_PATH}

CMD ["sh", "start.sh"]
