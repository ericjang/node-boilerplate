#!/bin/sh
echo "Creating necessary folders"
mkdir ./static
mkdir ./static/images
mkdir ./static/css
mkdir ./static/js
mkdir ./views
mkdir ./models
mkdir ./test

echo "Copying Markup and Bootstrap Boilerplate"
cp ./templates/app/server.js ./server.js
cp ./templates/app/server.coffee ./server.coffee
cp ./templates/app/package.json ./package.json
cp ./templates/app/.gitignore ./.gitignore
cp ./templates/app/config.json ./config.json
cp ./templates/app/Makefile ./Makefile
cp ./templates/test/stub.js ./test/stub.js

cp ./templates/views/500.jade ./views/500.jade
cp ./templates/views/404.jade ./views/404.jade
cp ./templates/views/index.jade ./views/index.jade
cp ./templates/views/about.jade ./views/about.jade
cp ./templates/views/contact.jade ./views/contact.jade
cp ./templates/views/layout.jade ./views/layout.jade
cp ./templates/js/script.js ./static/js/script.js
cp ./templates/js/script.coffee ./static/js/script.coffee

#bootstrap-related things
cp ./templates/js/bootstrap.min.js ./static/js/bootstrap.min.js
cp ./templates/css/bootstrap.min.css ./static/css/bootstrap.min.css
cp ./templates/css/bootstrap-responsive.min.css ./static/css/bootstrap-responsive.min.css

#create DevNotes.txt file
touch DevNotes.txt

echo "Setting up the dependencies from NPM..."
npm install

echo "Removing the stuff you dont want..."
rm -rf .git
rm -rf templates
rm README.md
rm -rf initproject.sh

echo "Initing the new git project..."
git init
git add .
git commit -m"Initial Commit"

