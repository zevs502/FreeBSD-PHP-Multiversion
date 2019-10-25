# Created by: John Chen <johnpupu@gmail.com>
# $FreeBSD: head/devel/pecl-APCu/Makefile 512557 2019-09-22 07:14:00Z antoine $

PORTNAME=	APCu
PORTVERSION=	5.1.17
CATEGORIES=	devel
DISTNAME=	${PORTNAME:tl}-${PORTVERSION}

MAINTAINER=	zevs5@zevs5.ru
COMMENT=	APC User Caching

LICENSE=	PHP301
LICENSE_FILE=	${WRKSRC}/LICENSE

CONFLICTS_INSTALL=	pecl-APC

OPTIONS_RADIO=		PHP-V
OPTIONS_RADIO_PHP-V=	PHP72 PHP73

OPTIONS_DEFAULT=PHP72

PHP-V_DESC=	Please select PHP version or unselect all option
PHP72_DESC=	PHP extension for pecl-APC to version PHP 7.2
PHP73_DESC=	PHP extension for pecl-APC to version PHP 7.3

.include <bsd.port.pre.mk>

.if ${PORT_OPTIONS:MPHP72} || ${PORT_OPTIONS:MPHP73}
USES=		localbase phpm:pecl

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

PLIST_FILES=	${DATADIR}/${PORTCURSUFFIX}/apc.php

post-install:
	${MKDIR} ${STAGEDIR}${DATADIR}/${PORTCURSUFFIX}
	${INSTALL_DATA} ${WRKSRC}/apc.php ${STAGEDIR}${DATADIR}/${PORTCURSUFFIX}

.else
USES=		localbase php:pecl

PLIST_FILES=	${DATADIR}/apc.php

post-install:
	${MKDIR} ${STAGEDIR}${DATADIR}
	${INSTALL_DATA} ${WRKSRC}/apc.php ${STAGEDIR}${DATADIR}
.endif

IGNORE_WITH_PHP=	74
PHP_MODNAME=	${PORTNAME:tl}

.include <bsd.port.mk> 
