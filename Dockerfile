FROM ghcr.io/libretime/icecast:2.4.4

# Set environment variables
ENV ICECAST_SOURCE_PASSWORD=hackme \
    ICECAST_ADMIN_PASSWORD=hackme \
    ICECAST_ADMIN_USERNAME=admin \
    ICECAST_HOSTNAME=icecast-on-render-pj7t.onrender.com \
    ICECAST_LISTEN_PORT=${PORT}

# Create a writable directory for our files
RUN mkdir -p /app && chown -R icecast:icecast /app

# Copy entrypoint to a user-writable location
COPY --chown=icecast:icecast --chmod=+x entrypoint.sh /app/entrypoint.sh

# Switch to non-root user
USER icecast

# Use the entrypoint script
ENTRYPOINT ["/app/entrypoint.sh"]