./node_modules/.bin/coffeelint -f ./.coffeelintrc \
  ./src/Gruntfile.coffee ./src/**/*.coffee

EXIT=$?

EXAMPLES="vanilla angular bare"

for F in $EXAMPLES ; do
  cd examples/$F
  echo "Running tests in $(pwd)"
  npm i
  rm -rf node_modules/rupert-grunt/src
  cp -r ../../src ./node_modules/rupert-grunt
  npm test ; ERR=$?
  if [ $ERR -ne 0 ] ; then
    EXIT=$ERR
  fi
  cd -
done

exit $EXIT
