#!/bin/sh

profile=${2:-edl}

output=${3:-json}

if grep -q 'urs.earthdata.nasa.gov' ~/.netrc 
then
    printf "$(sed -e "/\[${profile}\]/,+6d" "${HOME}/.aws/credentials")"

    printf "\n\n[${profile}]\noutput = ${output}\nregion = us-west-2\n"

    wget --auth-no-challenge -q -O - ${1:-https://archive.podaac.earthdata.nasa.gov/s3credentials} | \
    sed 's/{//g;s/}//g;s/: / = /g;s/"//g;s/, /\n/g;s/expiration/#expiration/g' && printf "\n\n"
fi

