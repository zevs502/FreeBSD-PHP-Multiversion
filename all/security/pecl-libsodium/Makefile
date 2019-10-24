# Created by: Gasol Wu <gasol.wu@gmail.com>
# $FreeBSD: head/security/pecl-libsodium/Makefile 492001 2019-02-02 21:55:15Z sunpoet $

PORTNAME=	libsodium
PORTVERSION=	1.0.7
CATEGORIES=	security

MAINTAINER=	zevs5@zevs5.ru
COMMENT=	PHP wrapper for the Sodium cryptographic library

LICENSE=	BSD2CLAUSE

LIB_DEPENDS=	libsodium.so:security/libsodium

OPTIONS_RADIO=		PHP-V
OPTIONS_RADIO_PHP-V=	PHP56 PHP72 PHP73

OPTIONS_DEFAULT=PHP72

PHP-V_DESC=	Please select PHP version or unselect all option
PHP56_DESC=	PHP 5.6 wrapper for the Sodium cryptographic library
PHP72_DESC=	PHP 7.2 wrapper for the Sodium cryptographic library
PHP73_DESC=	PHP 7.3 wrapper for the Sodium cryptographic library

.include <bsd.port.pre.mk>

.if ${PORT_OPTIONS:MPHP56} || ${PORT_OPTIONS:MPHP72} || ${PORT_OPTIONS:MPHP73}
USES=		phpm:pecl

.if ${PORT_OPTIONS:MPHP56}
PORTCURSUFFIX=	5.6
PHPAPIVER=	20131226
IGNORE_WITH_PHP=	71 72 73 74
.endif
                                                                                    
.if ${PORT_OPTIONS:MPHP72}
PORTCURSUFFIX=	7.2
PHPAPIVER=	20170718
IGNORE_WITH_PHP=	71 56 73 74
.endif

.if ${PORT_OPTIONS:MPHP73}
PORTCURSUFFIX=	7.3
PHPAPIVER=	20180731
IGNORE_WITH_PHP=	71 72 56 74
.endif

.else
USES=		php:pecl
.endif

PORTSCOUT=	limit:^1\.

.include <bsd.port.mk> 
