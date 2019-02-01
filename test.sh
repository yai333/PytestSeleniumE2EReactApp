#!/usr/bin/env bash

# Declaring pytest arguments
export PYTEST_ARGUMENTS=${@: --url/http://localhost:3000}


# Run Selenium py.test with script arguments
# Map allure output xml to image folder
# Map root folder to image folder
# Set the working directory as the root folder in the image
# Set the PYTHONPATH to the root folder in the image
# Run the project image as declared above
docker run --rm "$PYTEST_ARGUMENTS"
