#!/bin/bash

echo "Initializing MySQL database..."
mysql -h 10.161.80.3 -u user -pqwe123!@# <<EOF
CREATE DATABASE IF NOT EXISTS petclinic;
EOF

echo "Adding sample data to the database..."
mysql -h 10.161.80.3 -u user -pqwe123!@# petclinic < /docker-entrypoint-initdb.d/data.sql

echo "Database initialization and data insertion complete."