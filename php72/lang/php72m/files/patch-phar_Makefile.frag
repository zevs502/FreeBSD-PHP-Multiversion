--- ./ext/phar/Makefile.frag.orig	2019-10-19 20:35:40.553381000 +0300
+++ ./ext/phar/Makefile.frag	2019-10-19 20:39:55.894854000 +0300
@@ -42,9 +42,9 @@
 
 install-pharcmd: pharcmd
 	-@$(mkinstalldirs) $(INSTALL_ROOT)$(bindir)
-	$(INSTALL) $(builddir)/phar.phar $(INSTALL_ROOT)$(bindir)
+	$(INSTALL) $(builddir)/phar.phar $(INSTALL_ROOT)$(bindir)/phar.phar$(program_suffix)
 	-@rm -f $(INSTALL_ROOT)$(bindir)/phar
-	$(LN_S) -f phar.phar $(INSTALL_ROOT)$(bindir)/phar
+	$(LN_S) -f phar.phar$(program_suffix) $(INSTALL_ROOT)$(bindir)/phar$(program_suffix)
 	@$(mkinstalldirs) $(INSTALL_ROOT)$(mandir)/man1
-	@$(INSTALL_DATA) $(builddir)/phar.1 $(INSTALL_ROOT)$(mandir)/man1/phar.1
-	@$(INSTALL_DATA) $(builddir)/phar.phar.1 $(INSTALL_ROOT)$(mandir)/man1/phar.phar.1
+	@$(INSTALL_DATA) $(builddir)/phar.1 $(INSTALL_ROOT)$(mandir)/man1/phar$(program_suffix).1
+	@$(INSTALL_DATA) $(builddir)/phar.phar.1 $(INSTALL_ROOT)$(mandir)/man1/phar.phar$(program_suffix).1
