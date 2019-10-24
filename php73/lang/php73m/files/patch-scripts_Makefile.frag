--- ./scripts/Makefile.frag.orig	2019-10-19 05:16:53.092983000 +0300
+++ ./scripts/Makefile.frag	2019-10-19 05:01:54.038768000 +0300
@@ -2,8 +2,8 @@
 # Build environment install
 #
 
-phpincludedir = $(includedir)/php
-phpbuilddir = $(libdir)/build
+phpincludedir = $(includedir)/php/$(FREEBSD_PHP_API)
+phpbuilddir = $(prefix)/lib/php/$(FREEBSD_PHP_API)/build
 
 BUILD_FILES = \
 	scripts/phpize.m4 \
