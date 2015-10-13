#!/bin/bash

set -ex

bundle config --delete without
bundle config --delete frozen

bundle

bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake
