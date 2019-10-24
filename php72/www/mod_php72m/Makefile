# $FreeBSD: head/www/mod_php72m/Makefile 454302 2017-11-16 10:48:48Z tz $

CATEGORIES=	www devel
PKGNAMEPREFIX=	mod_

MAINTAINER=	zevs5@zevs5.ru

PHP_PORT=	lang/php72m
MASTERDIR=	${.CURDIR}/../../${PHP_PORT}

OPTIONS_DEFINE=	AP2FILTER
OPTIONS_DEFAULT=AP24MOD

AP24MOD_DESC=   Use module Apache 24
AP2FILTER_DESC=	Use Apache 2.x filter interface (experimental)

.include "${MASTERDIR}/Makefile"
