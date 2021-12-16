# Evolution CMS
![Docker Build](https://github.com/749/docker-php-fpm-evolution/actions/workflows/docker-publish.yml/badge.svg)

A docker setup that is optimized to run Evolution CMS version 1.X.

## Simplified Usage
1. Copy the `.env.example` file to `.env`
2. Run `docker-compose up`
3. The Webserver will now listen on Ports `80` and `443`

## General
The build is completely automated, running every sunday at 00:00/GMT+0.

The build produces convenience tags so `1.14.15` is also tagged `1.14` and `1`
