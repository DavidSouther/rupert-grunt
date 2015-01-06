#!/bin/sh

FILES='.coffeelintrc .gitignore .jshintrc Gruntfile.coffee app.js package.json server.json src'
MODULES='vanilla angular'


for M in $MODULES ; do

    cd $M 
    tar -cf ../../dist/$M.tgz $FILES
    zip -r ../../dist/$M.zip $FILES
    cd -

done
