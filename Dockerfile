# Use the official PostgreSQL image from Docker Hub
FROM postgres:latest

# Set environment variables for PostgreSQL
ENV POSTGRES_USER=datauser
ENV POSTGRES_PASSWORD=mypassword
ENV POSTGRES_DB=sampledatabase

# Install jq and other necessary packages
RUN apt-get update && \
    apt-get install -y jq

COPY ./data/data.json /tmp/data/data.json
COPY init_data.sh /tmp/init_data.sh
RUN /tmp/init_data.sh && cp /tmp/init.sql /docker-entrypoint-initdb.d/init.sql

EXPOSE 5432
