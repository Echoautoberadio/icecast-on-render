#!/bin/sh

# Remplace le port dans le fichier de configuration XML
PORT=${PORT:-8000}
echo "🔧 Setting port to $PORT in icecast.xml"
sed -i "s/<port>8000<\/port>/<port>$PORT<\/port>/" /etc/icecast2/icecast.xml

# Lancer Icecast
exec /usr/bin/icecast -c /etc/icecast2/icecast.xml
