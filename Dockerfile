FROM ghcr.io/libretime/icecast:2.4.4

ENV ICECAST_SOURCE_PASSWORD=hackme \
    ICECAST_ADMIN_PASSWORD=hackme \
    ICECAST_ADMIN_USERNAME=admin \
    ICECAST_HOSTNAME=icecast-on-render-pj7t.onrender.com

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
