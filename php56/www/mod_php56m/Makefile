# $FreeBSD: branches/2019Q1/www/mod_php56m/Makefile 367268 2014-09-04 14:24:25Z ale $

CATEGORIES=	www devel
PKGNAMEPREFIX=	mod_

MAINTAINER=	zevs5@zevs5.ru

PHP_PORT=	lang/php56m
MASTERDIR=	${.CURDIR}/../../${PHP_PORT}

OPTIONS_DEFINE=	AP2FILTER
OPTIONS_DEFAULT=AP24MOD

AP24MOD_DESC=   Use module Apache 24
AP2FILTER_DESC=	Use Apache 2.x filter interface (experimental)

.include "${MASTERDIR}/Makefile"
