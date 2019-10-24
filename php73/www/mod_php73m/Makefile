# $FreeBSD: head/www/mod_php73/Makefile 481525 2018-10-08 08:52:51Z tz $

CATEGORIES=	www devel
PKGNAMEPREFIX=	mod_

MAINTAINER=	ports@FreeBSD.org

PHP_PORT=	lang/php73m
MASTERDIR=	${.CURDIR}/../../${PHP_PORT}

OPTIONS_DEFINE=	AP2FILTER
OPTIONS_DEFAULT=AP24MOD

AP24MOD_DESC=   Use module Apache 24
AP2FILTER_DESC=	Use Apache 2.x filter interface (experimental)

.include "${MASTERDIR}/Makefile"
