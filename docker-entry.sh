#!/usr/bin/env bash

set -ex

cd pytest

nginx

pytest -s --url http://localhost
