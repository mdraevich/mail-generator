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

show_overview() {
    echo "================ Overview ================"
    echo "-> mail_directory: $mail_directory_formatted"
    echo "-> mail_directory (packages): $mail_directory_size"
    echo "-> mail_to: $mail_to"
    echo "-> mail_server: $mail_server"
    echo "=========================================="
    echo ""
}

show_package_status() {
    # calculate percentage
    local sent_percentage=$(bc <<<"scale=1; $eml_files_sent * 100 / $eml_files_total")
    local rejected_percentage=$(bc <<<"scale=1; $eml_files_rejected * 100 / $eml_files_total")
    
    # print counters
    echo "=============== PACKAGE #$i ==============="
    echo "-> package_name: $(basename $package)"
    echo "-> mail sent/total: $eml_files_sent/$eml_files_total   ($sent_percentage%)"
    echo "-> mail rejected/total: $eml_files_rejected/$eml_files_total   ($rejected_percentage%)"
    echo ""
}

mail_directory_unformatted=$1
mail_to=$2
mail_server=$3

check_args  # run a function

mail_directory_formatted=$(realpath $mail_directory_unformatted)
let mail_directory_size=$(find $mail_directory_formatted -maxdepth 1 -type d | wc -l)-1

show_overview  # run a function
read -p "Do you want to start? [Confirm]" yes

i=0
for package in $mail_directory_formatted/* ; do
    let i=i+1  # increment test number

    # list of files to send
    eml_files=$(find $package -maxdepth 1 -type f)
    
    # counters for reporting
    eml_files_total=$(echo "$eml_files" | wc -l)
    eml_files_sent=0
    eml_files_rejected=0

    show_package_status  # run a function

    for eml_file in $eml_files ; do
        let rejected_flag=1

        # send eml file
        swaks \
            --silent 3 \
            --to $mail_to \
            --from package_$i@antispam.test.suite \
            --server $mail_server \
            --header "To: <$mail_to>" \
            --header "From: <package_$i@antispam.test.suite>" \
            --data $eml_file && \
            let rejected_flag=0  # if swaks return zero code, the message was accepted

        # update counters
        let eml_files_sent+=1
        let eml_files_rejected+=$rejected_flag

        # clear display
        printf "\033[5A"

        show_package_status  # run a function
    done
done
