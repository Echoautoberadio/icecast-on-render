FROM ghcr.io/libretime/icecast:2.4.4

ENV ICECAST_SOURCE_PASSWORD=hackme \
    ICECAST_ADMIN_PASSWORD=hackme \
    ICECAST_ADMIN_USERNAME=admin \
    ICECAST_HOSTNAME=icecast-on-render-pj7t.onrender.com \
    ICECAST_LISTEN_PORT=${PORT}

# Copy to a user-writable location instead of system bin
COPY entrypoint.sh /app/entrypoint.sh

# Set permissions using COPY's built-in chmod
COPY --chmod=+x entrypoint.sh /app/entrypoint.sh

# Use the new location
ENTRYPOINT ["/app/entrypoint.sh"]