FROM        docker.io/node:18-bullseye
COPY        mongodb.repo  /etc/yum.repos.d/mongo.repo
RUN         apt-get install unzip mongodb-org-shell -y
RUN         mkdir /app
WORKDIR     /tmp
ADD         https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip /tmp/catalogue.zip
WORKDIR     /app
RUN         unzip /tmp/catalogue.zip /app
RUN         npm install
COPY        run.sh /
ENTRYPOINT  ["bash","/run.sh"]

