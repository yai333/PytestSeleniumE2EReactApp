#!/usr/bin/env bash

# run pytest ($@ to derive parameters from commandline)
pwd

cd pytest

pytest -s --url http://localhost:5000
