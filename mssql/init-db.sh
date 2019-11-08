# Make sure SQL server started
sleep 15

# Initialize database and demo user
echo "$(date -u +'%Y-%m-%d %H:%M:%S.%2N') init-db     Initializing database and demo user"
LOG=`/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Admin:123 -i /init.sql`
echo "$(date -u +'%Y-%m-%d %H:%M:%S.%2N') init-db     $LOG"
