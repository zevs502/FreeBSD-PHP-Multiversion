%%APACHEMODDIR%%/%%AP_MODULE%%
@postexec %D/sbin/apxs -e -a -n %%AP_NAME%% %f
@preunexec %D/sbin/apxs -e -A -n %%AP_NAME%% %f
@dir etc/php/7.2/apache24/conf.d
