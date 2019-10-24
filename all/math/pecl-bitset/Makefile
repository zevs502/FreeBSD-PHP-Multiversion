# Created by: Greg Larkin <zevs5@zevs5.ru>
# $FreeBSD: head/math/pecl-bitset/Makefile 489108 2019-01-02 23:58:11Z sunpoet $

PORTNAME=	bitset
PORTVERSION=	3.0.1
CATEGORIES=	math

MAINTAINER=	zevs5@zevs5.ru
COMMENT=	PECL extension for manipulating bitsets

LICENSE=	PHP301
LICENSE_FILE=	${WRKSRC}/LICENSE

OPTIONS_RADIO=		PHP-V
OPTIONS_RADIO_PHP-V=	PHP56 PHP72 PHP73

OPTIONS_DEFAULT=PHP56

PHP-V_DESC=	Please select PHP version or unselect all option
PHP56_DESC=	extension for manipulating bitsets to version PHP 5.6
PHP72_DESC=	extension for manipulating bitsets to version PHP 7.2
PHP73_DESC=	extension for manipulating bitsets to version PHP 7.3

.include <bsd.port.pre.mk>

.if ${PORT_OPTIONS:MPHP56} || ${PORT_OPTIONS:MPHP72} || ${PORT_OPTIONS:MPHP73}
USES=		phpm:pecl

.if ${PORT_OPTIONS:MPHP56}
PORTCURSUFFIX=		5.6
PHPAPIVER=		20131226
IGNORE_WITH_PHP=	71 72 73 74
.endif
                                                                                    
.if ${PORT_OPTIONS:MPHP72}
PORTCURSUFFIX=		7.2
PHPAPIVER=		20170718
IGNORE_WITH_PHP=	71 56 73 74
.endif

.if ${PORT_OPTIONS:MPHP73}
PORTCURSUFFIX=		7.3
PHPAPIVER=		20180731
IGNORE_WITH_PHP=	71 72 56 74
.endif

.else
USES=		php:pecl
.endif

.include <bsd.port.mk>
 
