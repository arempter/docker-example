FROM ubuntu:latest
RUN apt-get update && \
    apt-get install -y mysql-client
CMD mysql
