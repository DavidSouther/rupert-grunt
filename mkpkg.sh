#!/bin/sh

FILES='.coffeelintrc .gitignore .jshintrc Gruntfile.coffee app.js package.json server.json src'

cd plain

tar -cf ../dist/plain.tgz $FILES
zip -r ../dist/plain.zip $FILES
