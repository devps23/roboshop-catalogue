FROM        docker.io/node:16
RUN         apt-get update && apt-get install -y wget gnupg
RUN         wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | apt-key add -
COPY        mongo.repo  /etc/apt/sources.list.d/mongodb-org-6.0.list
RUN         apt-get update
RUN         apt-get install unzip mongodb-mongosh -y
RUN         mkdir /app
WORKDIR     /tmp
ADD         https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip /tmp/catalogue.zip
WORKDIR     /app
RUN         unzip /tmp/catalogue.zip /app
RUN         npm install
COPY        run.sh /
ENTRYPOINT  ["bash","/run.sh"]

