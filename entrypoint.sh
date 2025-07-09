#!/bin/sh
set -e

# Debugging output
echo "=== Starting Icecast Server ==="
echo "Hostname: ${ICECAST_HOSTNAME}"
echo "Port: ${PORT}"
echo "Admin: ${ICECAST_ADMIN_USERNAME}"
echo "Source Password: ${ICECAST_SOURCE_PASSWORD}"
echo "Admin Password: ${ICECAST_ADMIN_PASSWORD}"

# Use Render's PORT if available, default to 8000
PORT=${PORT:-8000}

# Create configuration in user-writable space
CONFIG_PATH="/tmp/icecast.xml"

cat > "${CONFIG_PATH}" << EOF
<icecast>
    <location>Render</location>
    <admin>${ICECAST_ADMIN_USERNAME}</admin>
    
    <limits>
        <clients>100</clients>
        <sources>4</sources>
        <queue-size>524288</queue-size>
        <source-timeout>10</source-timeout>
    </limits>

    <authentication>
        <source-password>${ICECAST_SOURCE_PASSWORD}</source-password>
        <admin-user>${ICECAST_ADMIN_USERNAME}</admin-user>
        <admin-password>${ICECAST_ADMIN_PASSWORD}</admin-password>
    </authentication>

    <listen-socket>
        <port>${PORT}</port>
        <bind-address>0.0.0.0</bind-address>
    </listen-socket>
    
    <hostname>${ICECAST_HOSTNAME}</hostname>
    
    <fileserve>1</fileserve>
    
    <paths>
        <basedir>/usr/share/icecast</basedir>
        <logdir>/var/log/icecast</logdir>
        <webroot>/usr/share/icecast/web</webroot>
        <adminroot>/usr/share/icecast/admin</adminroot>
    </paths>
</icecast>
EOF

echo "✅ Configuration generated at ${CONFIG_PATH}"
echo "=== Starting Icecast ==="

# Start Icecast with the generated config
exec icecast -c "${CONFIG_PATH}"