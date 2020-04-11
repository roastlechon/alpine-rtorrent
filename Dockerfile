FROM alpine

LABEL maintainer="Gianluca Gabrielli" mail="tuxmealux+dockerhub@protonmail.com"
LABEL description="rTorrent on Alpine Linux, with a better Docker integration."
LABEL website="https://github.com/TuxMeaLux/alpine-rtorrent"
LABEL version="1.0"

ARG UGID=1000

RUN addgroup -g $UGID rtorrent && \
    adduser -S -u $UGID -G rtorrent rtorrent && \
    apk add --no-cache rtorrent && \
    mkdir -p /home/rtorrent/rtorrent/config.d && \
    mkdir /home/rtorrent/rtorrent/.session && \
    mkdir /home/rtorrent/rtorrent/download && \
    mkdir /home/rtorrent/rtorrent/watch && \
    mkdir /home/rtorrent/rtorrent/socket && \
    chown -R rtorrent:rtorrent /home/rtorrent/rtorrent

COPY --chown=rtorrent:rtorrent .rtorrent.rc /home/rtorrent/

VOLUME /home/rtorrent/rtorrent/config.d
VOLUME /home/rtorrent/rtorrent/socket
VOLUME /home/rtorrent/rtorrent/.session

EXPOSE 16891
EXPOSE 6881
EXPOSE 6881/udp
EXPOSE 50000

USER rtorrent

CMD ["rtorrent"]
