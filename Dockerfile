FROM        docker.io/node
COPY        mongodb-org-6.0.repo  /etc/yum.repos.d/mongodb-org-6.0.repo
RUN         apt-get install unzip mongodb-mongosh -y
RUN         mkdir /app
WORKDIR     /tmp
ADD         https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip /tmp/catalogue.zip
WORKDIR     /app
RUN         unzip /tmp/catalogue.zip /app
RUN         npm install
COPY        run.sh /
ENTRYPOINT  ["bash","/run.sh"]

