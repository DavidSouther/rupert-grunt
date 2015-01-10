./node_modules/.bin/coffeelint -f ./.coffeelintrc \
  ./src/Gruntfile.coffee ./src/**/*.coffee

EXIT=$?

EXAMPLES="vanilla angular bare"

npm ln
for F in $EXAMPLES ; do
  cd examples/$F
  echo "Running tests in $(pwd)"
  npm i ; npm ln rupert-grunt # Use local rupert-grunt
  npm test ; ERR=$?
  if [ $ERR -ne 0 ] ; then
    EXIT=$ERR
  fi
  cd -
done

exit $EXIT
