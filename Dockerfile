FROM        docker.io/redhat/ubi8
RUN         yum install wget -y
WORKDIR     /tmp
ADD         https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip /tmp/catalogue.zip
RUN         mkdir -p app
WORKDIR     /app
RUN         unzip /tmp/catalogue.zip -d /app/
RUN         rm -rf /tmp/*
RUN         npm install
COPY        curl -L -O /app/rds-combined-ca-bundle.pem  https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
COPY         run.sh /
ENTRYPOINT   ["bash","/run.sh"]








#  docker run -it docker.io/node:16 , default container weill create and check whether mysql will work or not
# kubectl run debug --image=rkalluru/debug, kubectl run debug --image=pdevops78/kubernetes/debug:cfdi


