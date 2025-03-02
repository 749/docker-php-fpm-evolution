# docker-evolution-revolution An auto-updating dockerfile to run evolution Revolution CMS
# Copyright (C) 2021  Jan Giesenberg <749@github.com>
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

FROM php:7-fpm-alpine

ARG SOURCE_VERSION=3.2.5
ENV MODX_NEWEST_VERSION=${SOURCE_VERSION}

LABEL org.opencontainers.image.authors="Jan Giesenberg <749@github.com>"

EXPOSE 9000

RUN apk add --no-cache rsync freetype-dev libpng-dev jpeg-dev unzip sudo bash gettext libxml2-dev curl-dev oniguruma-dev libzip-dev\
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install -j$(nproc) json gd mysqli pdo pdo_mysql simplexml curl mbstring opcache zip\
	&& rm -rf /usr/src/php/

COPY --chown=www-data files/docker-entrypoint.sh /entrypoint.sh
COPY --chown=www-data:www-data files/docker-entrypoint /docker-entrypoint
COPY files/php-config/ /usr/local/etc/php/conf.d/

RUN chmod +x /entrypoint.sh \
	&& mkdir -p /evolution/public/ \
	&& chown -R www-data:www-data /evolution

VOLUME /evolution/public


WORKDIR /evolution/public
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]