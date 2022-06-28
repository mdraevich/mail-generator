#!/bin/bash

# HOW TO USE
#    - send_mail.bash <mail_directory> <mail_to> <mail_server> 
#


check_args() {
    [ -z "$mail_directory_unformatted" ] && echo "<mail_directory> argument is null" && exit 
    [ -z "$mail_to" ] && echo "<mail_to> argument is null" && exit 
    [ -z "$mail_server" ] && echo "<mail_server> argument is null" && exit

    [ ! -d "$mail_directory_unformatted" ] && echo "<mail_directory> doesn't exist" && exit
}

mail_directory_unformatted=$1
mail_to=$2
mail_server=$3

check_args  # run a function

mail_directory_formatted=$(realpath $mail_directory_unformatted)
let mail_directory_size=$(find $full_path -maxdepth 1 -type d | wc -l)-1

echo "============ Overview ============"
echo "-> mail_directory: $mail_directory_formatted"
echo "-> mail_directory (size): $mail_directory_size"
echo "-> mail_to: $2"
echo "-> mail_server: $3"
echo "=================================="
echo ""

read -p "Do you want to start? [Confirm]" yes

i=0
for d in $1*/ ; do
    let i=i+1  # increment test number
    echo "=============== TEST #$i ==============="
    echo "-> mail_package: $d"
    echo "=================================="

done


# echo "=============== TEST # ==============="


# echo "[!] DEBUG: start sending $1 ==> [FortiMail]"
# for filename in $1/*; do
#     # send spam mail
#     swaks --silent 3 --server 10.1.10.2:1025 -t alex@10.1.10.2 -f $1@10.1.10.1 -d $filename
# done
# echo "[!] DEBUG: start sending $2 ==> [FortiMail]"
# for filename in $2/*; do
#     # send legitimate mail
#     swaks --silent 3 --server 10.1.10.2:1025 -t alex@10.1.10.2 -f $2@10.1.10.1 -d $filename
# done    


# echo "[!] DEBUG: start sending $1 ==> [VadeSecure]"
# for filename in $1/*; do
#     # send spam mail
#     swaks --silent 3 --server 10.1.10.2:1026 -t alex@10.1.10.2 -f $1@10.1.10.1 -d $filename
# done
# echo "[!] DEBUG: start sending $2 ==> [VadeSecure]"
# for filename in $2/*; do
#     # send legitimate mail
#     swaks --silent 3 --server 10.1.10.2:1026 -t alex@10.1.10.2 -f $2@10.1.10.1 -d $filename
# done


# echo "$1: $(tree $1 | tail -1)"
# echo "$2: $(tree $2 | tail -1)"
