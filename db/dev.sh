#!/bin/bash

# Check if the data directory is empty (ignoring .keep file)
if [ -z "$(ls -A /var/lib/postgresql/16/main --ignore='.keep')" ]; then
    echo "Data directory is empty. Copying initial data..."
    cp -a /var/lib/postgresql/init_data/. /var/lib/postgresql/16/main
fi

# Adjust ownership
chown -R postgres:postgres /var/lib/postgresql/16/main

# Start the postgres server
service postgresql start

# Tail the PostgreSQL log file to keep the container running
tail -f /var/log/postgresql/postgresql-16-main.log