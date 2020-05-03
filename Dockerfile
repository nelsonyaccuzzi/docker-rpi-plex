ARG PLEX_PATH=/opt/plex/Application
FROM arm32v7/debian:stretch-slim as src

ARG PLEX_PATH
ARG VERSION

RUN apt update && apt install -y wget ca-certificates locales \
 && wget --no-verbose -O /tmp/plex.tar https://downloads.plex.tv/plex-media-server-new/$VERSION/synology/PlexMediaServer-$VERSION-armv7hf.spk \
 && tar -xf /tmp/plex.tar -C /tmp \
 && mkdir -p $PLEX_PATH \
 && tar -xf /tmp/package.tgz -C $PLEX_PATH \
 && mv $PLEX_PATH/Resources/start.sh $PLEX_PATH/ \
 && sed -i '2i rm -rf /config/Library/Application\\ Support/Plex\\ Media\\ Server/plexmediaserver.pid' $PLEX_PATH/start.sh \
 && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen && locale-gen

FROM arm32v7/debian:stretch-slim

ARG PLEX_PATH

COPY --from=src $PLEX_PATH $PLEX_PATH
COPY --from=src /usr/lib/locale /usr/lib/locale

ENV HOME=/config

WORKDIR $PLEX_PATH

CMD ["sh", "start.sh"]
