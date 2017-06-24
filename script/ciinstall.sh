#!/usr/bin/env bash 
set -e # halt script on error 
 
# Clone down the template, get rid of .git, and copy it on top of the contents of this pages-ci branch 
cd .. 
git clone --depth=3 --branch=gh-pages https://github.com/BricksandMortar/plugin-doc-template.git 
rm -rf plugin-doc-template/.git 
cp -r -n -p plugin-doc-template/* $TRAVIS_BUILD_DIR/ 
cd $TRAVIS_BUILD_DIR 
 
# Install gems from the gemfile 
bundle install 
 
# Replace the suffix $VERSION_NUMBER with the env variable $TRAVIS_BUILD_NUMBER on all assets to prevent caching  
sed -i -e 's/$VERSION_NUMBER/'$TRAVIS_BUILD_NUMBER'/g' ./_layouts/*.html 
 
# Replace the commented base url variable (this is used to correctly build the site for production) 
sed -i -e  's/'#baseurl'/baseurl/' ./_config.yml 

# Replace the !NAME variable in _config.yml with the $NAME env variable from .travis.yml
sed -i -e  's/'!NAME'/$NAME/' ./_config.yml 

# Replace the !REPO variable in _config.yml with the $REPO env variable from .travis.yml
sed -i -e  's/'!REPO'/$REPO/' ./_config.yml 