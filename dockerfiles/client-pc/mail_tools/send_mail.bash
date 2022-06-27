#!/bin/bash

#
#
#

echo "[!] DEBUG: start sending $1 ==> [FortiMail]"
for filename in $1/*; do
    # send spam mail
    swaks --silent 3 --server 10.1.10.2:1025 -t alex@10.1.10.2 -f $1@10.1.10.1 -d $filename
done
echo "[!] DEBUG: start sending $2 ==> [FortiMail]"
for filename in $2/*; do
    # send legitimate mail
    swaks --silent 3 --server 10.1.10.2:1025 -t alex@10.1.10.2 -f $2@10.1.10.1 -d $filename
done    


echo "[!] DEBUG: start sending $1 ==> [VadeSecure]"
for filename in $1/*; do
    # send spam mail
    swaks --silent 3 --server 10.1.10.2:1026 -t alex@10.1.10.2 -f $1@10.1.10.1 -d $filename
done
echo "[!] DEBUG: start sending $2 ==> [VadeSecure]"
for filename in $2/*; do
    # send legitimate mail
    swaks --silent 3 --server 10.1.10.2:1026 -t alex@10.1.10.2 -f $2@10.1.10.1 -d $filename
done


echo "$1: $(tree $1 | tail -1)"
echo "$2: $(tree $2 | tail -1)"
