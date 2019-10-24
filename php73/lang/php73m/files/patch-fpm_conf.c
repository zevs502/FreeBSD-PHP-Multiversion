--- ./sapi/fpm/fpm/fpm_conf.c.orig	2019-10-19 05:11:53.396602000 +0300
+++ ./sapi/fpm/fpm/fpm_conf.c	2019-10-19 05:01:54.022376000 +0300
@@ -1718,7 +1718,7 @@
 		char *tmp;
 
 		if (fpm_globals.prefix == NULL) {
-			spprintf(&tmp, 0, "%s/php-fpm.conf", PHP_SYSCONFDIR);
+			spprintf(&tmp, 0, "%s/php/%d.%d/fpm/php-fpm.conf", PHP_SYSCONFDIR, PHP_MAJOR_VERSION, PHP_MINOR_VERSION);
 		} else {
 			spprintf(&tmp, 0, "%s/etc/php-fpm.conf", fpm_globals.prefix);
 		}
