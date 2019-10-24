--- ./sapi/apache2handler/config.m4.orig	2019-10-19 05:16:52.824180000 +0300
+++ ./sapi/apache2handler/config.m4	2019-10-19 05:01:54.065206000 +0300
@@ -56,14 +56,6 @@
 
   APACHE_CFLAGS="$APACHE_CPPFLAGS -I$APXS_INCLUDEDIR $APR_CFLAGS $APU_CFLAGS -DZEND_ENABLE_STATIC_TSRMLS_CACHE=1"
 
-  # Test that we're trying to configure with apache 2.x
-  PHP_AP_EXTRACT_VERSION($APXS_HTTPD)
-  if test "$APACHE_VERSION" -le 2000000; then
-    AC_MSG_ERROR([You have enabled Apache 2 support while your server is Apache 1.3.  Please use the appropriate switch --with-apxs (without the 2)])
-  elif test "$APACHE_VERSION" -lt 2000044; then
-    AC_MSG_ERROR([Please note that Apache version >= 2.0.44 is required])
-  fi
-
   APXS_LIBEXECDIR='$(INSTALL_ROOT)'`$APXS -q LIBEXECDIR`
   if test -z `$APXS -q SYSCONFDIR`; then
     INSTALL_IT="\$(mkinstalldirs) '$APXS_LIBEXECDIR' && \
