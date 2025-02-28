# roboshop-catalogue

Connect
Getting Started Guide  | Enabling/Disabling TLS  | Connecting programmatically
Download the Amazon DocumentDB Certificate Authority (CA) certificate required to authenticate to your instance
Copy
wget https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem

Connect to this instance with the mongo shell

Copy
mongosh docdb.cluster-cvkemucwmc9p.us-east-1.docdb.amazonaws.com:27017 --tls --tlsCAFile global-bundle.pem --retryWrites=false --username docdb --password roboshop12345

Connect to this instance with an application

Copy
mongodb://docdb:roboshop12345@docdb.cluster-cvkemucwmc9p.us-east-1.docdb.amazonaws.com:27017/?tls=true&tlsCAFile=global-bundle.pem&replicaSet=rs0&readPreference=secondaryPreferred&retryWrites=false


DOCUMENTDB == 'true'
mongodb://docdb:roboshop12345@docdb.cluster-cvkemucwmc9p.us-east-1.docdb.amazonaws.com:27017/catalogue?tls=true&replicaSet=rs0&readPreference=secondaryPreferred&retryWrites=false'

mongodb://docdb:roboshop12345@docdb-2025-02-28-08-02-29.cluster-cvkemucwmc9p.us-east-1.docdb.amazonaws.com:27017/catalogue?tls=true&replicaSet=rs0&readPreference=secondaryPreferred&retryWrites=false

mongodb://docdb:roboshop12345@docdb-2025-02-28-08-02-29.cluster-cvkemucwmc9p.us-east-1.docdb.amazonaws.com:27017/?tls=true&tlsCAFile=global-bundle.pem&replicahttps://truststore.pki.rds.amazonaws.com/global/global-bundle.pemSet=rs0&readPreference=secondaryPreferred&retryWrites=false


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