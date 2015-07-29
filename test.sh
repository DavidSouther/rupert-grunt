set -x

./node_modules/.bin/coffeelint -f ./.coffeelintrc ./src/Gruntfile.coffee \
  ./src/**/*.coffee

EXIT=$?

START_DIR=$(pwd)

mkdir -p _nm/rupert-grunt
cp -r ./{README.md,LICENSE,package.json,src,steps.coffee} \
  _nm/rupert-grunt
cd _nm/rupert-grunt
npm i
cd ../..

EXAMPLES="vanilla angular bare"
EXAMPLES="vanilla"

for F in $EXAMPLES ; do
  NM=./examples/$F/node_modules
  rm -rf $NM
  mkdir -p $NM/
  cp -r _nm/rupert-grunt $NM/rupert-grunt
  cd examples/$F
  echo "Running tests in $(pwd)"
  # npm install --production && npm i grunt grunt-cli  && npm test
  npm i && npm test
  ERR=$?
  if [ $ERR -ne 0 ] ; then
    EXIT=$ERR
  fi
  cd $START_DIR
done

rm -rf _nm
set +x

exit $EXIT
