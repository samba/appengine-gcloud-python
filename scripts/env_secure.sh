#!/bin/sh

# In some cases sensitive data is passed (encrypted) in environment variables, encoded base-64. 
# This script makes it easy to populate files from that data, or otherwise read it.

STASH=${HOME}/.secure/stash

mkdir -p ${STASH}

CYPHER=aes-256-cbc

case "$1" in
  decode)
    # Simply decode from STDIN
    openssl ${CYPHER} -k "${2}" -a -d
    ;;
  encode)
    # Encode data from STDIN (for preparing the environment vars config)
    openssl ${CYPHER} -k "${2}" -a -e
    ;;
  env)
    password="$2"; shift 2;
    for i in "$@"; do
      # decode the value from the environ
      value=$(eval echo "\$$i" | openssl ${CYPHER} -k "${password}" -a -d)
      # present the export directive
      eval echo "export $i=\\\"$value\\\""
    done
    ;;
  file)  
    # populate a temporary file
    tempfile=`mktemp ${STASH}/data.XXXXXXX`;
    openssl ${CYPHER} -k "${2}" -a -d > $tempfile
    echo $tempfile | tee -a ${STASH}/index
    ;;
  clean)
    test -f ${STASH}/index && cat ${STASH}/index | xargs -d '\n' rm -v 
    test -f ${STASH}/index && rm -v ${STASH}/index
    ;;
esac
