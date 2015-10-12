#!/bin/bash

set -ex

export RAILS_ENV="test"
export RACK_ENV="test"

export POSTGRES_USER="ubuntu"
export POSTGRES_PASS=""
export POSTGRES_HOST="127.0.0.1"
export POSTGRES_PORT="5432"
export DATABASE_NAME="circle_test"

export DATABASE_URL="postgres://${POSTGRES_USER}:${POSTGRES_PASS}@${POSTGRES_HOST}:${POSTGRES_PORT}/${DATABASE_NAME}"

exec "$@"
