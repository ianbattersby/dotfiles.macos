#!/bin/bash

function typescript_use_local() {
  if [ -d 'node_modules/typescript/bin' ]; then
      command node_modules/typescript/bin/tsc
  else
      echo "Unable to locate TypeScript compiler, perhaps 'npm i typescript --save-dev'?"
  fi
}

alias tsc='typescript_use_local'
