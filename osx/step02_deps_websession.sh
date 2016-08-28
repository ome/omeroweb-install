#!/bin/bash

set -e -u -x

# Install redis
brew install redis
brew services start redis
