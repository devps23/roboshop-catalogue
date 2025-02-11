if [ -z "$DOCUMENTDB" ] ; then
  echo Environment DOCUMENTDB is missing
  exit 1
fi

if [ -z "$MONGO_URL" ] ; then
  echo Environment MONGO_URL is missing
  exit 1
fi

node /app/server.js




