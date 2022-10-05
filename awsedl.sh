#!/bin/bash
if grep -q "urs.earthdata.nasa.gov" "${HOME}/.netrc"
then
    [[ -f $1 ]] && printf "$(sed -e "/\[${3:-"edl"}\]/,+6d" "$1")\n\n"
    printf "[${3:-"edl"}]\n" && echo "output = json" && echo "region = us-west-2"
    wget --auth-no-challenge -q -O - "${2:-"https://archive.podaac.earthdata.nasa.gov/s3credentials"}" | \
        sed 's/{//g;s/}//g;s/: / = /g;s/"//g;s/, /\n/g;s/expiration/#expiration/g;s/accessKeyId/aws_access_key_id/g;s/secretAccessKey/aws_secret_access_key/g;s/sessionToken/aws_session_token/g'
fi