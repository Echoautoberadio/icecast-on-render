# Updated Dockerfile
FROM ghcr.io/libretime/icecast:2.4.4

ENV ICECAST_SOURCE_PASSWORD=hackme \
    ICECAST_ADMIN_PASSWORD=hackme \
    ICECAST_ADMIN_USERNAME=admin \
    ICECAST_HOSTNAME=icecast-on-render-pj7t.onrender.com \
    ICECAST_LISTEN_PORT=${PORT}

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# 🔧 ADD THIS LINE (fixes permission issue)
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]