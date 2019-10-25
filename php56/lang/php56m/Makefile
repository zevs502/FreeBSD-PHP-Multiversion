# Created by: Alex Dupre <ale@FreeBSD.org>
# $FreeBSD: branches/2019Q1/lang/php56/Makefile 487169 2018-12-10 14:19:22Z ale $

PORTNAME=	php56m
PORTVERSION=	5.6.40
PORTREVISION?=	0
CATEGORIES?=	lang devel www
MASTER_SITES=	PHP/distributions
DISTNAME=	php-${PORTVERSION}
PORTCURSUFFIX=	5.6
PHPAPIVER=	20131226

MAINTAINER=	zevs5@zevs5.ru
COMMENT=	PHP Scripting Language

LICENSE=	PHP301

DEPRECATED=	Security Support ends on 31 Dec 2018
EXPIRATION_DATE=2019-01-01

USES+=		tar:xz cpe
CPE_PRODUCT=	php
NO_OPTIONS_SORT=yes

.if !defined(PKGNAMESUFFIX)
LIB_DEPENDS=	libpcre.so:devel/pcre

GNU_CONFIGURE=	yes
CONFIGURE_ARGS+=--with-layout=GNU \
		--sysconfdir="${PREFIX}/etc" \
		--program-suffix="${PORTCURSUFFIX}" \
		--libexecdir=${PREFIX}/lib/php/${PORTCURSUFFIX} \
		--datadir=${PREFIX}/share/php/${PORTCURSUFFIX} \
		--disable-all \
		--enable-cli \
		--enable-libxml \
		--with-libxml-dir=${LOCALBASE} \
		--with-pcre-regex=${LOCALBASE} \
		--program-prefix="" \
		--with-pic \
		--without-pear
USES+=		autoreconf:build gnome
USE_GNOME=	libxml2
# PR230207 Allow relocations against read-only segments (override lld default)
LDFLAGS_i386=	-Wl,-z,notext

OPTIONS_DEFINE+=DEBUG DTRACE IPV6 MAILHEAD MYSQLND LINKTHR ZTS
.if defined(PKGNAMEPREFIX)
OPTIONS_DEFAULT+=DTRACE MYSQLND IPV6 LINKTHR ZTS MAILHEAD
.else
OPTIONS_DEFAULT=DTRACE MYSQLND IPV6 LINKTHR ZTS MAILHEAD
.endif
# Bug 197128:  No ASM code for MIPS/MIPS64, disable FPM
OPTIONS_EXCLUDE_mips=FPM
OPTIONS_EXCLUDE_mips64=FPM
OPTIONS_SUB=	yes

DEBUG_DESC=	Enable debug
DTRACE_DESC=	Enable DTrace support
MAILHEAD_DESC=	Enable mail header patch
MYSQLND_DESC=	Build with MySQL Native Driver
LINKTHR_DESC=	Link thread lib (for threaded extensions)
ZTS_DESC=	Force Zend Thread Safety (ZTS) build

CONFLICTS=	php70-* php71-* php72-* php73-*

DESTDIRNAME=	INSTALL_ROOT

.include <bsd.port.pre.mk>

PATCH_DIST_STRIP=	-p1

PATCH_SITES+=	LOCAL/ale

.if ${PORT_OPTIONS:MMAILHEAD}
PATCHFILES+=	php-5.5.x-mail-header.patch:mail
PATCH_SITES+=	http://choon.net/opensource/php/:mail
.endif

.if ${PORT_OPTIONS:MMYSQLND}
CONFIGURE_ARGS+=--enable-mysqlnd
.endif

.if defined(PKGNAMEPREFIX)

.if ${PORT_OPTIONS:MCLI}
PHP_SAPI+=	cli
CONFIGURE_ARGS+=--disable-cgi
CONFIGURE_ARGS+=--with-config-file-path="${PREFIX}/etc/php/${PORTCURSUFFIX}/cli"
CONFIGURE_ARGS+=--with-config-file-scan-dir="${PREFIX}/etc/php/${PORTCURSUFFIX}/cli/conf.d"
PLIST=		${PKGDIR}/pkg-plist.cli
.endif

.if ${PORT_OPTIONS:MCGI}
PHP_SAPI+=	cgi
CONFIGURE_ARGS+=--disable-phpdbg
CONFIGURE_ARGS+=--with-config-file-path="${PREFIX}/etc/php/${PORTCURSUFFIX}/cgi"
CONFIGURE_ARGS+=--with-config-file-scan-dir="${PREFIX}/etc/php/${PORTCURSUFFIX}/cgi/conf.d"
PLIST=		${PKGDIR}/pkg-plist.cgi
.else
CONFIGURE_ARGS+=--disable-cgi
.endif

.if ${PORT_OPTIONS:MFPM}
PHP_SAPI+=	fpm
USE_RC_SUBR+=	php${PORTCURSUFFIX}-fpm
CONFIGURE_ARGS+=--enable-fpm \
		--with-fpm-user=${WWWOWN} \
		--with-fpm-group=${WWWGRP}
CONFIGURE_ARGS+=--with-config-file-path="${PREFIX}/etc/php/${PORTCURSUFFIX}/fpm"
CONFIGURE_ARGS+=--with-config-file-scan-dir="${PREFIX}/etc/php/${PORTCURSUFFIX}/fpm/conf.d"
PLIST=		${PKGDIR}/pkg-plist.fpm
.endif

.if ${PORT_OPTIONS:MAP24MOD}
USES+=		apache:2.2+
.include "${PORTSDIR}/Mk/Uses/apache.mk"
.if ${PORT_OPTIONS:MAP2FILTER}
CONFIGURE_ARGS+=--with-apxs2filter=${APXS}
.else
CONFIGURE_ARGS+=--with-apxs2=${APXS}
.endif
PLIST=		${PKGDIR}/pkg-plist.mod
PKGMESSAGE=	${PKGDIR}/pkg-message.mod
MODULENAME=	libphp5
SHORTMODNAME=	php5
.endif

.if ${PORT_OPTIONS:MEMBED}
PHP_SAPI+=	embed
CONFIGURE_ARGS+=--enable-embed
CONFIGURE_ARGS+=--with-config-file-path="${PREFIX}/etc/php/${PORTCURSUFFIX}/embed"
CONFIGURE_ARGS+=--with-config-file-scan-dir="${PREFIX}/etc/php/${PORTCURSUFFIX}/embed/conf.d"
CONFIGURE_ARGS+=--without-mm
PLIST=		${PKGDIR}/pkg-plist.embed
EMBEDNAME=	libphp5
.endif

.if ${PORT_OPTIONS:MPHPDBG}
PHP_SAPI+=	phpdbg
CONFIGURE_ARGS+=--enable-phpdbg
.if ${PORT_OPTIONS:MDEBUG}
CONFIGURE_ARGS+=--enable-phpdbg-debug
.endif
CONFIGURE_ARGS+=--with-config-file-path="${PREFIX}/etc/php/${PORTCURSUFFIX}/phpdbg"
CONFIGURE_ARGS+=--with-config-file-scan-dir="${PREFIX}/etc/php/${PORTCURSUFFIX}/phpdbg/conf.d"
PLIST=		${PKGDIR}/pkg-plist.phpdbg
.endif

.else
PHP_SAPI+=	cli cgi fpm
CONFIGURE_ARGS+=--disable-phpdbg \
		--enable-fpm \
		--enable-phar \
		--with-fpm-user=${WWWOWN} \
		--with-fpm-group=${WWWGRP} \
		--with-config-file-path="${PREFIX}/etc/php/${PORTCURSUFFIX}/apache24" \
		--with-config-file-scan-dir="${PREFIX}/etc/php/${PORTCURSUFFIX}/apache24/conf.d"
.endif

.if ${PORT_OPTIONS:MCLI} || ${PORT_OPTIONS:MEMBED}
PLIST_SUB+=	SAPI_INC=""
.else
PLIST_SUB+=	SAPI_INC="@comment "
.endif

.if !defined(WITH_REGEX_TYPE) || ${WITH_REGEX_TYPE} == "php"
CONFIGURE_ARGS+=--with-regex=php
.elif defined(WITH_REGEX_TYPE) && ${WITH_REGEX_TYPE} == "system"
CONFIGURE_ARGS+=--with-regex=system
.endif

.if !defined(WITH_ZEND_VM) || ${WITH_ZEND_VM} == "CALL"
CONFIGURE_ARGS+=--with-zend-vm=CALL
.elif defined(WITH_ZEND_VM) && ${WITH_ZEND_VM} == "SWITCH"
CONFIGURE_ARGS+=--with-zend-vm=SWITCH
.elif defined(WITH_ZEND_VM) && ${WITH_ZEND_VM} == "GOTO"
CONFIGURE_ARGS+=--with-zend-vm=GOTO
.endif

CONFIGURE_ENV+=	ac_cv_pthreads_lib="" \
		ac_cv_pthreads_cflags="" \
		ac_cv_decimal_fp_supported="no" \
		pthreads_working="yes" \
		lt_cv_path_SED="sed"

.if ${PORT_OPTIONS:MLINKTHR}
LIBS+=		-lpthread
.endif

.if ${PORT_OPTIONS:MDEBUG}
CONFIGURE_ARGS+=--enable-debug
.endif

.if ${PORT_OPTIONS:MZTS}
CONFIGURE_ARGS+=--enable-maintainer-zts
.endif

.if ${PORT_OPTIONS:MDTRACE}
CONFIGURE_ARGS+=--enable-dtrace
PLIST_SUB+=	DTRACE=""
.else
PLIST_SUB+=	DTRACE="@comment "
.endif

.if empty(PORT_OPTIONS:MIPV6)
CONFIGURE_ARGS+=--disable-ipv6
.endif

post-patch:
	@${TOUCH} ${WRKSRC}/ext/php_config.h
	@${REINPLACE_CMD} "s|^\(extension_dir\)|; \1|" ${WRKSRC}/php.ini-*
	@${CP} -f ${WRKSRC}/ext/ext_skel ${WRKSRC}/ext/ext_skel.in
.if ${PORT_OPTIONS:MFPM}
	@${REINPLACE_CMD} -e "s|^;\(pid\)|\1|;s|^;\(pm\.[a-z_]*_servers\)|\1|" \
		${WRKSRC}/sapi/fpm/php-fpm.conf.in
.endif

pre-configure:
	@(cd ${WRKSRC} && ${SETENV} MAKE=${MAKE_CMD} ./buildconf --force)

.if !defined(PKGNAMEPREFIX)
post-build:
	@${ECHO_CMD} "PHP_VER=56" > ${WRKDIR}/php.conf
	@${ECHO_CMD} "PHP_VERSION=${PORTVERSION}" >> ${WRKDIR}/php.conf
	@${ECHO_CMD} "PHP_SAPI=${PHP_SAPI}" >> ${WRKDIR}/php.conf
	@${ECHO_CMD} "PHP_EXT_INC=pcre spl" >> ${WRKDIR}/php.conf
	@${ECHO_CMD} -n "PHP_EXT_DIR=" >> ${WRKDIR}/php.conf
	@${SH} ${WRKSRC}/scripts/php-config --extension-dir | ${SED} -ne 's,^${PREFIX}/lib/php/,,p' >> ${WRKDIR}/php.conf

test: build
	@(cd ${WRKSRC} && ${MAKE} test)

INSTALL_TARGET=		install-headers
INSTALL_TARGET+=	install-build
INSTALL_TARGET+=	install-programs
INSTALL_TARGET+=	install-pharcmd

post-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/etc/php/${PORTCURSUFFIX}
	${INSTALL_DATA} ${WRKSRC}/php.ini-development ${WRKSRC}/php.ini-production \
		${WRKDIR}/php.conf ${STAGEDIR}/${PREFIX}/etc/php/${PORTCURSUFFIX}
.else
test: build
	@(cd ${WRKSRC} && ${MAKE} test)

.if ${PORT_OPTIONS:MAP24MOD}
do-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/${APACHEMODDIR}
	${INSTALL_LIB} ${WRKSRC}/libs/${MODULENAME}.so \
		${STAGEDIR}${PREFIX}/${APACHEMODDIR}

post-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/etc/php/${PORTCURSUFFIX}/apache24/conf.d

.endif

.if ${PORT_OPTIONS:MCLI}

INSTALL_TARGET=		install-cli

post-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/etc/php/${PORTCURSUFFIX}/cli/conf.d

.endif

.if ${PORT_OPTIONS:MCGI}

INSTALL_TARGET=		install-cgi

post-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/etc/php/${PORTCURSUFFIX}/cgi/conf.d

.endif

.if ${PORT_OPTIONS:MFPM}

INSTALL_TARGET=		install-fpm

post-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/etc/php/${PORTCURSUFFIX}/fpm/conf.d
	${LN} -s php-fpm${PORTCURSUFFIX} ${STAGEDIR}${PREFIX}/sbin/php_fpm56


.endif

.if ${PORT_OPTIONS:MEMBED}

do-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/lib
	${INSTALL_LIB} ${WRKSRC}/libs/${EMBEDNAME}.so \
		${STAGEDIR}${PREFIX}/lib/

post-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/etc/php/${PORTCURSUFFIX}/embed/conf.d
	${MKDIR} ${STAGEDIR}${PREFIX}/include/php/${PHPAPIVER}/sapi/embed
	${CP} -r ${WRKSRC}/sapi/embed/php_embed.h \
		${STAGEDIR}${PREFIX}/include/php/${PHPAPIVER}/sapi/embed/

.endif

.if ${PORT_OPTIONS:MPHPDBG}

INSTALL_TARGET=		install-phpdbg

post-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/etc/php/${PORTCURSUFFIX}/phpdbg/conf.d

.endif

.endif

.else

.include "${MASTERDIR}/Makefile.ext"
.endif
.include <bsd.port.post.mk>
