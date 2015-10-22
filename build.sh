#!/bin/bash

# only proceed script when started not by pull request (PR)
if [ $TRAVIS_PULL_REQUEST == "true" ]; then
  echo "this is PR, exiting"
  exit 0
fi

# enable error reporting to the console
set -e

# build site with jekyll, by default to `_site' folder
def build

# cleanup
rm -rf ../scrum_developer.github.io.master

#clone `master' branch of the repository using encrypted GH_TOKEN for authentification
git clone https://${GH_TOKEN}@github.com/Wowip/scrum_developer.github.io.git ../scrum_developer.github.io.master

# copy generated HTML site to `master' branch
cp -R _site/* ../scrum_developer.github.io.master

# commit and push generated content to `master' branch
# since repository was cloned in write mode with token auth - we can push there
cd ../scrum_developer.github.io.master
git config user.email "arturoinosencio@gmail.com"
git config user.name "Wowip"
git add -A .
git commit -a -m "Travis #$TRAVIS_BUILD_NUMBER"
git push --quiet origin master > /dev/null 2>&1 