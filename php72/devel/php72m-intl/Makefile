# $FreeBSD: head/devel/php72m-intl/Makefile 481525 2018-10-08 08:52:51Z tz $

CATEGORIES=	devel

MASTERDIR=	${.CURDIR}/../../lang/php72m

PKGNAMESUFFIX=	-intl

USES=		compiler:c++11-lib
USE_CXXSTD=	gnu++11

CPPFLAGS+=	-DU_USING_ICU_NAMESPACE=1

TEST_TARGET=	test

.include "${MASTERDIR}/Makefile"
