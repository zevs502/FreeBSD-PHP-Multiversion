# $FreeBSD: head/security/pecl-mcrypt/Makefile 512714 2019-09-24 13:38:54Z pizzamig $

PORTNAME=	mcrypt
PORTVERSION=	1.0.3
CATEGORIES=	security pear

MAINTAINER=	zevs5@zevs5.ru
COMMENT=	PHP extension for mcrypt, removed in PHP 7.2

LICENSE=	PHP301

IGNORE_WITH_PHP=	71

LIB_DEPENDS=	libltdl.so:devel/libltdl \
		libmcrypt.so:security/libmcrypt

OPTIONS_RADIO=		PHP-V
OPTIONS_RADIO_PHP-V=	PHP72 PHP73

OPTIONS_DEFAULT=PHP72

PHP-V_DESC=	Please select PHP version or unselect all option
PHP72_DESC=	PHP extension for mcrypt to version PHP 7.2
PHP73_DESC=	PHP extension for mcrypt to version PHP 7.3

.include <bsd.port.pre.mk>

.if ${PORT_OPTIONS:MPHP72} || ${PORT_OPTIONS:MPHP73}
USES=		phpm:pecl
                                                                                    
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

.include <bsd.port.mk> 
