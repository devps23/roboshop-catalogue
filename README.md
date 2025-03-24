# roboshop-catalogue

Connect
Getting Started Guide  | Enabling/Disabling TLS  | Connecting programmatically
Download the Amazon DocumentDB Certificate Authority (CA) certificate required to authenticate to your instance
Copy
wget https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem  /app/rds-combined-ca-bundle.pem

Connect to this instance with the mongo shell

Copy
mongosh docdb.cluster-cvkemucwmc9p.us-east-1.docdb.amazonaws.com:27017 --tls --tlsCAFile global-bundle.pem --retryWrites=false --username docdb --password roboshop12345

Connect to this instance with an application

Copy
mongodb://docdb:roboshop12345@docdb.cluster-cvkemucwmc9p.us-east-1.docdb.amazonaws.com:27017/?tls=true&tlsCAFile=global-bundle.pem&replicaSet=rs0&readPreference=secondaryPreferred&retryWrites=false


DOCUMENTDB == 'true'
mongodb://docdb:roboshop12345@docdb.cluster-cvkemucwmc9p.us-east-1.docdb.amazonaws.com:27017/catalogue?tls=true&replicaSet=rs0&readPreference=secondaryPreferred&retryWrites=false'

mongodb://docdb:roboshop12345@docdb-2025-02-28-08-02-29.cluster-cvkemucwmc9p.us-east-1.docdb.amazonaws.com:27017/catalogue?tls=true&replicaSet=rs0&readPreference=secondaryPreferred&retryWrites=false

mongodb://docdb:roboshop12345@docdb-2025-02-28-08-02-29.cluster-cvkemucwmc9p.us-east-1.docdb.amazonaws.com:27017/catalogue?tls=true&tlsCAFile=global-bundle.pem&replicahttps://truststore.pki.rds.amazonaws.com/global/global-bundle.pemSet=rs0&readPreference=secondaryPreferred&retryWrites=false
mongodb://docdb:roboshop12345@docdb.cluster-cvkemucwmc9p.us-east-1.docdb.amazonaws.com:27017/catalogue?tls=true&replicaSet=rs0&readPreference=secondaryPreferred&retryWrites=false

first step:
===========
1. check the server connected to mongodb or not
telnet docdb:roboshop12345@docdb.cluster-cvkemucwmc9p.us-east-1.docdb.amazonaws.com 27017
if server connected to docdb
2. tail -f /var/log/messages
we will get pem file error
3. for this "curl -L -o /app/rds-combined-ca-bundle.pem https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem"
4. restart catalogue service
5. if we get any warning error: systemctl daemon-reload
6. check logs whether mongodb connected or not
7. once install mongoshell 
mongosh docdb-2025-02-28-08-02-29.cluster-cvkemucwmc9p.us-east-1.docdb.amazonaws.com:27017 --tls --tlsCAFile global-bundle.pem --retryWrites=false --username docdb --password roboshop12345
8. once connected then load schema into this mongo
9. mongosh docdb-2025-02-28-08-02-29.cluster-cvkemucwmc9p.us-east-1.docdb.amazonaws.com:27017 --tls --tlsCAFile global-bundle.pem --retryWrites=false --username docdb --password roboshop12345 </app/schema/catalogue.js



---------------------------------------------------------------------------------------------------------
steps for catalogue in roboshop:
================================
1. make a docker file
2. add environment variables
3. DOCUMENTDB and MONGO_URL
4. add these two variables in vault
5. DOCUMENTDB=true
6. MONGO_URL="mongodb://docdb:roboshop12345@docdb.cluster-cvkemucwmc9p.us-east-1.docdb.amazonaws.com:27017/catalogue?tls=true&replicaSet=rs0&readPreference=secondaryPreferred&retryWrites=false"
7. this data get from vault-init-container 
8. vault kv get $SECRET_NAME | sed -n -e '/== Data ==/,$ p' | grep -Ev '== Data ==|^Key|^value|^---'| awk '{print "export " $1"="$2}'>/data/secrets.txt
9. here we get mongourl from vault with doublequotes so for this
   awk '{print "export " $1"="\"$2"\}', it will display along with double qoutes

we need to debug in run.sh like

echo /data/secrets.txt
echo
echo
env, this is a environment variable whether to check variables store in env or not
10. Add PEM file in Dockerfile
ADD  curl -L -O https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem /app/global-bundle.pem
11. schema will load only once, so here we should go for kubernetes "jobs"
12. create kubernetes "jobs"  under "templates"
13. install mongosh
* sudo vi /etc/yum.repos.d/mongodb-org-6.0.repo, create a repo file
* Add the following content in repo file
* [mongodb-org-6.0]
  name=MongoDB Repository
  baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/6.0/x86_64/
  gpgcheck=1
  enabled=1
  gpgkey=https://www.mongodb.org/static/pgp/server-6.0.asc

* Install mogosh 
* sudo yum install -y mongodb-mongosh
* verify installation
  mongosh,This should start the MongoDB Shell, and you can use it to connect to your MongoDB instance.
* mongosh docdb-2025-02-28-08-02-29.cluster-cvkemucwmc9p.us-east-1.docdb.amazonaws.com:27017 --tls --tlsCAFile global-bundle.pem --retryWrites=false --username docdb --password roboshop12345 </app/schema/catalogue.js
