#!/bin/bash

declare project_dir="$(PWD)"
declare dc_app="${project_dir}"/docker/docker-compose-app.yml
declare app="bookmarks-ui"

function restart() {
    stop
    start
}

function start_app() {
    echo "Starting ${app} and dependencies...."
    build_api
    docker-compose -f "${dc_app}" up --build --force-recreate -d
    docker-compose -f "${dc_app}" logs -f
}

function stop_app() {
    echo 'Stopping all....'
    docker-compose -f "${dc_app}" stop
    docker-compose -f "${dc_app}" rm -f
}

function build_api() {
    ./mvnw clean package
}

action="start"

if [[ "$#" != "0"  ]]
then
    action=$@
fi

eval "${action}"
