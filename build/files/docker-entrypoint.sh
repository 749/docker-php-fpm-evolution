#!/usr/bin/env bash
set -ex

PATH_APP_BASE=/evolution
PATH_APP_PUBLIC=$PATH_APP_BASE/public

if [[ "$1" == apache2* ]] || [ "$1" == php-fpm ]; then
	if [ -n "$MYSQL_PORT_3306_TCP" ]; then
		if [ -z "$APP_DB_HOST" ]; then
			APP_DB_HOST='mysql'
		else
			echo >&2 'warning: both APP_DB_HOST and MYSQL_PORT_3306_TCP found'
			echo >&2 "  Connecting to APP_DB_HOST ($APP_DB_HOST)"
			echo >&2 '  instead of the linked mysql container'
		fi
	fi

	if [ -z "$APP_DB_HOST" ]; then
		echo >&2 'error: missing APP_DB_HOST and MYSQL_PORT_3306_TCP environment variables'
		echo >&2 '  Did you forget to --link some_mysql_container:mysql or set an external db'
		echo >&2 '  with -e APP_DB_HOST=hostname:port?'
		exit 1
	fi

	# if we're linked to MySQL and thus have credentials already, let's use them
	: ${APP_DB_USER:=${MYSQL_ENV_MYSQL_USER:-root}}
	if [ "$APP_DB_USER" = 'root' ]; then
		: ${APP_DB_PASSWORD:=$MYSQL_ENV_MYSQL_ROOT_PASSWORD}
	fi
	: ${APP_DB_PASSWORD:=$MYSQL_ENV_MYSQL_PASSWORD}
	: ${APP_DB_NAME:=${MYSQL_ENV_MYSQL_DATABASE:-evolution}}

	if [ -z "$APP_DB_PASSWORD" ]; then
		echo >&2 'error: missing required APP_DB_PASSWORD environment variable'
		echo >&2 '  Did you forget to -e APP_DB_PASSWORD=... ?'
		echo >&2
		echo >&2 '  (Also of interest might be APP_DB_USER and APP_DB_NAME.)'
		exit 1
	fi

	TERM=dumb php -- "$APP_DB_HOST" "$APP_DB_USER" "$APP_DB_PASSWORD" "$APP_DB_NAME" </docker-entrypoint/create-database.php
fi

#export static files
chown -R www-data:www-data $PATH_APP_BASE
cd $PATH_APP_PUBLIC

echo "Latest version of ModX Evolution is: $MODX_NEWEST_VERSION"
echo "Starting up $@"
exec "$@"
