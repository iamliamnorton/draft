#!/bin/bash

set -ex

export RAILS_ENV="test"

export POSTGRES_USER="postgres"
export POSTGRES_PASS="password"
export POSTGRES_HOST="postgres"
export POSTGRES_PORT="5432"
export DATABASE_NAME="draft_test"

export DATABASE_URL="postgres://${POSTGRES_USER}:${POSTGRES_PASS}@${POSTGRES_HOST}:${POSTGRES_PORT}/${DATABASE_NAME}"

exec "$@"
