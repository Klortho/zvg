#!/bin/bash

SCRIPTS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASE=`realpath $SCRIPTS/..`
LIB="$BASE/lib"

if [ -e "$LIB" ]; then
  echo 'It seems the lib/ directory already exists. Please clean up first.'
  exit 1
fi

mkdir -p "$LIB"
wget -O "$LIB/ramda.js" \
  https://cdnjs.cloudflare.com/ajax/libs/ramda/0.21.0/ramda.js  
wget -O "$LIB/raphael.js" \
  https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.3/raphael.js

# Copy the git hook for auto-deploy
HOOKS="$BASE/.git/hooks"
cp "$SCRIPTS/deploy-git-hook.sh" "$HOOKS/post-commit"
cp "$SCRIPTS/deploy-git-hook.sh" "$HOOKS/post-merge"
