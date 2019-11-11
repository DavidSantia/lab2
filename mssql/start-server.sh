# Initialize process
/init-db.sh &

# Start server
exec /opt/mssql/bin/sqlservr
