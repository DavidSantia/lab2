-- Create words db
CREATE DATABASE words

-- Create and enable demo login
CREATE LOGIN demo WITH PASSWORD=N'Welcome:123', DEFAULT_DATABASE=words
ALTER LOGIN demo ENABLE
GO

-- Create and enable login for New Relic OHI
CREATE LOGIN newrelic WITH PASSWORD=N'NewRelic:123', DEFAULT_DATABASE=master
ALTER LOGIN newrelic ENABLE
CREATE USER newrelic FOR LOGIN newrelic
GRANT CONNECT SQL TO newrelic
GRANT VIEW SERVER STATE TO newrelic
GRANT VIEW ANY DEFINITION TO newrelic
GO

-- Give New Relic OHI user read access to other databases
USE words
CREATE USER newrelic FOR LOGIN newrelic
GO

-- Create stats table
CREATE TABLE stats (
    Name varchar(128) NOT NULL,
    Count int NOT NULL
)

-- Create demo user, with access to words db
CREATE USER demo FOR LOGIN demo
ALTER ROLE db_owner ADD MEMBER demo
GO
