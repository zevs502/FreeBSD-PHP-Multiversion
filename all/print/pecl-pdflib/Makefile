# Created by: Alex Dupre <zevs5@zevs5.ru>
# $FreeBSD: head/print/pecl-pdflib/Makefile 513392 2019-09-30 14:46:11Z ale $
 
PORTNAME=	pdflib
PORTVERSION=	4.1.3
CATEGORIES=	print pear

MAINTAINER=	zevs5@zevs5.ru
COMMENT=	PECL extension to create PDF on the fly

LICENSE=	PHP30

LIB_DEPENDS=	libpdf.so:print/pdflib

OPTIONS_RADIO=		PHP-V
OPTIONS_RADIO_PHP-V=	PHP56 PHP72 PHP73

OPTIONS_DEFAULT=PHP56

PHP-V_DESC=	Please select PHP version or unselect all option
PHP56_DESC=	Build PDF module to version PHP 5.6
PHP72_DESC=	Build PDF module to version PHP 7.2
PHP73_DESC=	Build PDF module to version PHP 7.3

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

USE_PHP=	gd:build
PHP_MODNAME=	pdf

CONFIGURE_ARGS= --with-pdflib=${LOCALBASE}

.include <bsd.port.mk>
