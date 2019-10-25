# Created by: Gea-Suan Lin <gslin@gslin.org>
# $FreeBSD: head/databases/pecl-memcached/Makefile 512557 2019-09-22 07:14:00Z antoine $

PORTNAME=	memcached
PORTVERSION=	3.1.3
CATEGORIES=	databases

MAINTAINER=	zevs5@zevs5.ru
COMMENT=	PHP extension for interfacing with memcached via libmemcached library

LICENSE=	PHP30
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	libmemcached>=1.0.18:databases/libmemcached
LIB_DEPENDS=	libmemcached.so:databases/libmemcached

OPTIONS_RADIO=		PHP-V
OPTIONS_RADIO_PHP-V=	PHP56 PHP72 PHP73

OPTIONS_DEFAULT=PHP72

PHP-V_DESC=	Please select PHP version or unselect all option
PHP56_DESC=	Build PDF module to version PHP 5.6
PHP72_DESC=	Build PDF module to version PHP 7.2
PHP73_DESC=	Build PDF module to version PHP 7.3

.if ${PORT_OPTIONS:MPHP72} || ${PORT_OPTIONS:MPHP72} || ${PORT_OPTIONS:MPHP73}

USES=		phpm:pecl pkgconfig

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
USES=		php:pecl pkgconfig
IGNORE_WITH_PHP=	74
.endif

USE_PHP=	json:build session:build

CONFIGURE_ARGS=	--with-libmemcached-dir=${LOCALBASE}

OPTIONS_DEFINE=	IGBINARY SASL
OPTIONS_DEFAULT=SASL
IGBINARY_DESC=	Binary serializer support

IGBINARY_CONFIGURE_ENABLE=	memcached-igbinary
IGBINARY_USE=		PHP=igbinary:build
SASL_CONFIGURE_ENABLE=	memcached-sasl
SASL_LIB_DEPENDS=	libsasl2.so:security/cyrus-sasl2

.include <bsd.port.mk> 
