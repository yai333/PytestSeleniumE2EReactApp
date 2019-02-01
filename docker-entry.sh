#!/usr/bin/env bash

set -ex

cd pytest

pytest -s --url http://localhost:5000
