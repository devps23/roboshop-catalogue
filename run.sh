source data/secrets.txt
echo data/secrets.txt
cat data/secrets.txt
echo
echo
echo
env
# ,,,the above four steps are debugging whether these variables are available in env or not

if [ -z "${DOCUMENTDB}" ] ; then
  echo Environment DOCUMENTDB is missing
  exit 1
fi

if [ -z "${MONGO_URL}" ] ; then
  echo Environment MONGO_URL is missing
  exit 1
fi

node /app/server.js




