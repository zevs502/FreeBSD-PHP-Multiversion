# Created by: Gerrit Beine <tux@pinguru.net>
# $FreeBSD: head/databases/pecl-memcache/Makefile 507397 2019-07-27 11:51:41Z sunpoet $

PORTNAME=	memcache
PORTVERSION=	4.0.4
CATEGORIES=	databases

MAINTAINER=	zevs5@zevs5.ru
COMMENT=	Unofficial Memcached extension

LICENSE=	PHP30
LICENSE_FILE=	${WRKSRC}/LICENSE

OPTIONS_DEFINE= EXAMPLES

OPTIONS_RADIO=		PHP-V
OPTIONS_RADIO_PHP-V=	PHP56 PHP72 PHP73

OPTIONS_DEFAULT=PHP72

PHP-V_DESC=	Please select PHP version or unselect all option
PHP56_DESC=	Build PDF module to version PHP 5.6
PHP72_DESC=	Build PDF module to version PHP 7.2
PHP73_DESC=	Build PDF module to version PHP 7.3

.include <bsd.port.pre.mk>

.if ${PORT_OPTIONS:MPHP56} || ${PORT_OPTIONS:MPHP72} || ${PORT_OPTIONS:MPHP73}

USES=		dos2unix phpm:pecl

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
USES=		dos2unix php:pecl
.endif
USE_PHP=	session:build zlib:build

CONFIGURE_ARGS=	--with-zlib-dir=/usr
USE_CSTD=	gnu89

USE_GITHUB=	yes
GH_ACCOUNT=	websupport-sk
GH_PROJECT=	pecl-memcache

post-install-EXAMPLES-on:
	${MKDIR} ${STAGEDIR}${EXAMPLESDIR}/
	${INSTALL_DATA} ${WRKSRC}/example.php ${STAGEDIR}${EXAMPLESDIR}/

.include <bsd.port.mk> 
