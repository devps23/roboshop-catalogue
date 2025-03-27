FROM             docker.io/node:16
RUN              mkdir /app
COPY            *.js package.json /app/
WORKDIR          /app
RUN              npm install
RUN              wget -O /app/rds-combined-ca-bundle.pem https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
COPY             run.sh run.sh
ENTRYPOINT       ["bash","run.sh"]




#  docker run -it docker.io/node:16 , default container weill create and check whether mysql will work or not
# kubectl run debug --image=rkalluru/debug, kubectl run debug --image=pdevops78/kubernetes/debug:cfdi



