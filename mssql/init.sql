-- Create words db
CREATE DATABASE words

-- Create and enable demo login
CREATE LOGIN demo WITH PASSWORD=N'Welcome:123', DEFAULT_DATABASE=words
ALTER LOGIN demo ENABLE
GO

-- Create stats table
USE words
CREATE TABLE stats (
    Name varchar(128) NOT NULL,
    Count int NOT NULL
)

-- Create demo user, with access to words db
CREATE USER demo FOR LOGIN demo
ALTER ROLE db_owner ADD MEMBER demo
GO
