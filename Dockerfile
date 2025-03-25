FROM             docker.io/node:16
RUN              apt-get update && apt-get install -y wget unzip curl && \
                 apt-get clean && rm -rf /var/lib/apt/lists/*
WORKDIR          /tmp
RUN              curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
RUN              unzip /tmp/catalogue.zip
RUN              mkdir -p app
WORKDIR          /app
RUN              mv /tmp/* /app/
RUN              rm -rf /tmp/*
RUN              npm install
RUN              wget -O /app/global-bundle.pem https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
COPY             run.sh /
ENTRYPOINT       ["bash","/run.sh"]








#  docker run -it docker.io/node:16 , default container weill create and check whether mysql will work or not
# kubectl run debug --image=rkalluru/debug, kubectl run debug --image=pdevops78/kubernetes/debug:cfdi


