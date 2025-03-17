FROM        docker.io/node:16
RUN         apt-get update && \
            apt-get install -y wget gnupg unzip && \
            wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | apt-key add -
COPY        mongo.repo  /etc/apt/sources.list.d/mongodb-org-6.0.list
RUN         apt-get update && \
            apt-get install -y mongodb-mongosh && \
            apt-get clean && \
            rm -rf /var/lib/apt/lists/*
RUN         mkdir /app
WORKDIR     /tmp
ADD         https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip /tmp/catalogue.zip
WORKDIR     /app
RUN         unzip /tmp/catalogue.zip -d /app/
RUN         rm -rf /tmp/*
RUN         npm install
COPY        run.sh /
ENTRYPOINT  ["bash","/run.sh"]

