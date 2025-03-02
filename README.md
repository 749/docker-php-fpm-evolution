# Evolution CMS Docker

![Docker Build](https://github.com/749/docker-php-fpm-evolution/actions/workflows/docker-publish.yml/badge.svg)

A docker setup that is optimized to run [Evolution CMS](https://github.com/evolution-cms/evolution).

> The image itself does not contain Evolution CMS, it needs to be manually unpacked and mounted at `/evolution/public` in the container.

## Simplified Usage

1. Copy the `.env.example` file to `.env`
2. Modify at least the passwords in `.env`
3. Run `docker-compose up`
4. The Webserver will now listen on Ports `80` and `443`

## General

The build is completely automated, running every sunday at 00:00/GMT+0.

The build produces convenience tags so `1.14.15` is also tagged `1.14` and `1`

## Support

The image is created for the following platforms, however I only use arm64 and amd64 so those are actively tested. Support for the others may be dropped if the build proves to difficult to maintain.

<!-- prettier-ignore -->
| Platform     | Support |
| ------------ | ------- |
| linux/amd64  | ✅      |
| linux/arm64  | ✅      |
| linux/arm/v7 | ❓      |
| linux/386    | ❌      |
| linux/arm/v6 | ❌      |
