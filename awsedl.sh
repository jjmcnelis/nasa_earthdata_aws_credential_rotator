#!/bin/sh
profile=${2:-edl}
if grep -q 'urs.earthdata.nasa.gov' ~/.netrc 
then
    mkdir -p ~/.aws && touch ~/.aws/credentials && \
        printf "$(sed -e "/\[${profile}\]/,+6d" "${HOME}/.aws/credentials")"
    printf "\n\n[${profile}]\noutput = json\nregion = us-west-2\n"
    wget --auth-no-challenge -q -O - ${1:-https://archive.podaac.earthdata.nasa.gov/s3credentials} | \
        sed 's/{//g;s/}//g;s/: / = /g;s/"//g;s/, /\n/g;s/expiration/#expiration/g;s/accessKeyId/aws_access_key_id/g;s/secretAccessKey/aws_secret_access_key/g;s/sessionToken/aws_session_token/g' && \
        printf "\n\n"
fi
