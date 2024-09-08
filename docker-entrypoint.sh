#!/bin/bash
set -e

# Run database migrations
bundle exec rake db:migrate

# Seed the database
bundle exec rake db:seed

# Then exec the container's main process (what's set as CMD in the Dockerfile)
exec "$@"
