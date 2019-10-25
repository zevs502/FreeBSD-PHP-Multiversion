# $FreeBSD: head/databases/pecl-redis/Makefile 510882 2019-09-02 22:50:34Z swills $

PORTNAME=	redis
PORTVERSION=	5.0.2
CATEGORIES=	databases

MAINTAINER=	zevs5@zevs5.ru
COMMENT=	Extension to access Redis

LICENSE=	PHP301
LICENSE_FILE=	${WRKSRC}/COPYING

OPTIONS_DEFINE=	IGBINARY
OPTIONS_RADIO=		PHP-V
OPTIONS_RADIO_PHP-V=	PHP72 PHP73

OPTIONS_DEFAULT=PHP72

PHP-V_DESC=	Please select PHP version or unselect all option
PHP72_DESC=	Build PDF module to version PHP 7.2
PHP73_DESC=	Build PDF module to version PHP 7.3
IGBINARY_DESC=	Build with Igbinary serializer

.include <bsd.port.pre.mk>

.if ${PORT_OPTIONS:MPHP72} || ${PORT_OPTIONS:MPHP73}

USES=		phpm:pecl
                                                                                    
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

USE_PHP=	hash:build json:build session:build

IGBINARY_CONFIGURE_ENABLE=	redis-igbinary
IGBINARY_USE=			PHP=igbinary:build

.include <bsd.port.mk> 
