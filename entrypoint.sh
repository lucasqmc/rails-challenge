#!/bin/bash
set -e
bundle install

# Remove a potentially pre-existing server.pid for Rails.
rm -f tmp/pids/server.pid

bundle exec rails server -b 0.0.0.0 -p 3000