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
    | sort \
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

# White Label Service
get_version white-label-service
WLS_VERSION=`cat white-label-service-version.txt`
wget -O white-label-service.yaml "https://app.swaggerhub.com/apiproxy/schema/file/the-dcg/white-label-service/${WLS_VERSION}/swagger.yaml"

cd -
