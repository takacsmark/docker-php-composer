## Overview

This repository contains a Docker image with PHP and the Composer package manager. 

The Dockerfile has ONBUILD triggers to copy `composer.json` and the `public` directory from your project into the image.

Once `composer.json` is copied into the image composer install is triggered with ONBUILD.
