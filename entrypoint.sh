#!/bin/sh
set -e

# Use default port if $PORT not set
PORT=${PORT:-8000}

cat > /etc/icecast.xml << EOF
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
        <!-- Allow connections from any IP -->
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

echo "✅ Icecast configuration generated"
echo "Starting Icecast server on port ${PORT}..."

exec icecast -c /etc/icecast.xml