#!/bin/sh
set -e
cd "$(dirname "$0")/.."

# get latest public version of the an API and save to a .txt file
get_version()
{
    API_NAME=$1
    gron "https://app.swaggerhub.com/apiproxy/schema/file/the-dcg/${API_NAME}" \
    | grep -Eo 'https:\/\/api\.swaggerhub\.com\/apis\/the-dcg\/.*\/([0-9\.]+)' \
    | grep -o '[0-9\.]*$' \
    | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n \
    | tail -1 \
    > ${API_NAME}-version.txt
}

# Restaurant Service
get_version restaurant-service
RS_VERSION=`cat restaurant-service-version.txt`
wget -O restaurant-service.yaml "https://app.swaggerhub.com/apiproxy/schema/file/the-dcg/restaurant-service/${RS_VERSION}/swagger.yaml"

# Membership Service
get_version membership-service
MS_VERSION=`cat membership-service-version.txt`
wget -O membership-service.yaml "https://app.swaggerhub.com/apiproxy/schema/file/the-dcg/membership-service/${MS_VERSION}/swagger.yaml"

cd -
