# $FreeBSD: head/lang/php72m/Makefile 513271 2019-09-29 21:06:30Z tz $

PORTNAME=	php72m
DISTVERSION=	7.2.23
PORTREVISION?=	0
CATEGORIES?=	lang devel www
MASTER_SITES=	PHP/distributions
DISTNAME=	php-${DISTVERSION}
PORTCURSUFFIX=	7.2
PHPAPIVER=	20170718

MAINTAINER=	zevs5@zevs5.ru
COMMENT=	PHP Scripting Language

LICENSE=	PHP301

USES+=		tar:xz cpe
CPE_PRODUCT=	php
NO_OPTIONS_SORT=yes

.if !defined(PKGNAMESUFFIX)
LIB_DEPENDS=	libpcre.so:devel/pcre \
		libargon2.so:security/libargon2

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
		--with-password-argon2=${LOCALBASE} \
		--program-prefix="" \
		--with-pic \
		--without-pear
USES+=		autoreconf:build
USE_GNOME=	libxml2

# PR230207 Allow relocations against read-only segments (override lld default)
LDFLAGS_i386=	-Wl,-z,notext

OPTIONS_DEFINE+=DEBUG DTRACE IPV6 MYSQLND LINKTHR ZTS
.if defined(PKGNAMEPREFIX)
OPTIONS_DEFAULT+=DTRACE MYSQLND IPV6 LINKTHR ZTS
.else
OPTIONS_DEFAULT=DTRACE MYSQLND IPV6 LINKTHR ZTS
.endif

OPTIONS_EXCLUDE_DragonFly=	DTRACE
# ld(1) fails to link probes: Relocations in generic ELF (EM: 0)
OPTIONS_EXCLUDE_aarch64=	DTRACE
# dt_modtext:opensolaris/ib/libdtrace/common/dt_link.c: arm not impemented
OPTIONS_EXCLUDE_armv6=		DTRACE
OPTIONS_EXCLUDE_armv7=		DTRACE
# Bug 197128:  No ASM code for MIPS/MIPS64, disable FPM
OPTIONS_EXCLUDE_mips=		DTRACE FPM
OPTIONS_EXCLUDE_mips64=		DTRACE FPM
OPTIONS_EXCLUDE_sparc64=	DTRACE
OPTIONS_SUB=	yes

DEBUG_DESC=	Enable debug
DTRACE_DESC=	Enable DTrace support
MYSQLND_DESC=	Build with MySQL Native Driver
LINKTHR_DESC=	Link thread lib (for threaded extensions)
ZTS_DESC=	Force Zend Thread Safety (ZTS) build

CONFLICTS=	php56-* php70-* php71-* php73-*

DESTDIRNAME=	INSTALL_ROOT

.include <bsd.port.pre.mk>

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
CONFIGURE_ARGS+=--disable-phpdbg \
		--disable-cgi
.include "${PORTSDIR}/Mk/Uses/apache.mk"
.if ${PORT_OPTIONS:MAP2FILTER}
CONFIGURE_ARGS+=--with-apxs2filter=${APXS}
.else
CONFIGURE_ARGS+=--with-apxs2=${APXS}
.endif
CONFIGURE_ARGS+=--with-config-file-path="${PREFIX}/etc/php/${PORTCURSUFFIX}/apache24"
CONFIGURE_ARGS+=--with-config-file-scan-dir="${PREFIX}/etc/php/${PORTCURSUFFIX}/apache24/conf.d"
PLIST=		${PKGDIR}/pkg-plist.mod
PKGMESSAGE=	${PKGDIR}/pkg-message.mod
MODULENAME=	libphp7
SHORTMODNAME=	php7
.endif

.if ${PORT_OPTIONS:MEMBED}
PHP_SAPI+=	embed
CONFIGURE_ARGS+=--enable-embed
CONFIGURE_ARGS+=--with-config-file-path="${PREFIX}/etc/php/${PORTCURSUFFIX}/embed"
CONFIGURE_ARGS+=--with-config-file-scan-dir="${PREFIX}/etc/php/${PORTCURSUFFIX}/embed/conf.d"
CONFIGURE_ARGS+=--without-mm
PLIST=		${PKGDIR}/pkg-plist.embed
EMBEDNAME=	libphp7
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

CONFIGURE_ENV+=	ac_cv_decimal_fp_supported="no" \
		lt_cv_path_SED="sed"

.if ${PORT_OPTIONS:MLINKTHR}
LIBS+=		-lpthread
.endif

.if ${PORT_OPTIONS:MDEBUG}
CONFIGURE_ARGS+=--enable-debug
.endif

.if ${PORT_OPTIONS:MZTS}
CONFIGURE_ARGS+=--enable-maintainer-zts
CONFIGURE_ENV+=	pthreads_working="yes"
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
	@${ECHO_CMD} "PHP_VER=72" > ${WRKDIR}/php.conf
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
	${LN} -s php-fpm${PORTCURSUFFIX} ${STAGEDIR}${PREFIX}/sbin/php_fpm72


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
