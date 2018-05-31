## Overview

This repository contains a Docker image with PHP and the
Composer package manager.
**The image is meant to be used as the parent image for your
Dockerfile in your PHP Composer project.** Use it with the
`FROM` instruction in your Dockerfile and build your image on
top of it.

This image uses the latest version of Composer. You can find
details about Composer installation in `composer-
install.sh`.Composer installation is based on this description:
[https://getcomposer.org/doc/faqs/how-to-install-composer-
programmatically.md](https://getcomposer.org/doc/faqs/how-to-
install-composer-programmatically.md).

## Usage

This image has Composer installed and available as a global
command called `composer`. You can use it in your Dockerfile to
install your PHP packages described in your `composer.json`
file.

### Dockerfile example

You can create a Dockerfile based on this image and use it in
your project, here is an example:
```
FROM takacsmark/php-composer:7.2.2-apache
COPY ./composer.json /var/www/html/

RUN composer install && \
  rm -rf /var/www/html/composer-cache
COPY ./public /var/www/html/public
```

### `composer.json` example

Please make sure to specify a composer cache location. The above
Dockerfile assumes that your composer cache is located in your
working directory and is called `composer-cache`. You can clean
up your composer cache location as shown in the Dockerfile
example above.

The below sample `composer.json` shows how to specify the
`cache-dir` and has some sample Slim packages.

```
{
	"config": {
			"cache-dir": "/var/www/html/composer-cache"
	},
	"require": {
			"slim/slim": "^3.0"
	}
}
```
