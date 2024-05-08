# syntax=docker/dockerfile:1
#
ARG IMAGEBASE=frommakefile
#
FROM ${IMAGEBASE}
#
ENV \
    LANG=C.UTF-8 \
    TERM=screen-256color
#
RUN set -xe \
    # && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && apk add --no-cache --purge -uU \
        ca-certificates \
        tzdata \
        unzip \
        weechat \
        weechat-matrix \
        weechat-perl \
        weechat-python \
    && pip3 install --break-system-packages --no-cache-dir \
        six \
        websocket-client \
    && rm -rf /var/cache/apk/* /tmp/*
#
COPY root/ /
#
VOLUME /home/${S6_USER:-alpine}/ /home/${S6_USER:-alpine}/.weechat/
#
EXPOSE 9001
#
ENTRYPOINT ["/usershell"]
CMD ["weechat"]
