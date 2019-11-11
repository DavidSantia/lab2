FROM mcr.microsoft.com/mssql/server

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD="Admin:123"

ADD init.sql /
ADD init-db.sh /
ADD start-server.sh /

ENTRYPOINT /start-server.sh
