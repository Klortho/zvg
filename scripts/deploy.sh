#!/bin/bash
# This pushes the dist.
# It is invoked by git hooks such that it runs whenever `master` changes.

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $DIR/deploy-env.sh

DIST="$DIR/../dist"


if [ "$DEPLOY_LOC" == "" ]; then
  echo "Tried to publish, but you need to set DEPLOY_LOC"
  exit 1
fi
if [ ! -e $DIST ]; then
  echo "Tried to publish, but there's no distribution directory"
  exit 1
fi

echo "Publishing to $DEPLOY_LOC"
rsync -av $DIR/../dist/ --delete -e ssh $DEPLOY_LOC

