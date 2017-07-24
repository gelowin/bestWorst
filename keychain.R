## eval "$(ssh-agent -s)"
## ssh-add ~/.ssh/id_rsa
## 
## 
## bajarse el keychain y poner esta linea en el .bashrc
## ssh-agent persistency
## eval `keychain --eval --agents ssh id_rsa`
## 
## git config --global user.name "Angel Martinez-Perez"
## git config --global user.email gelowin33@yahoo.es
## git config --global core.editor emacs
## git config --list
## 
## Host github.com
## 	HostName github.com
## 	User git
## 	IdentityFile ~/.ssh/id_rsa
## 
## chmod 600 ~/.ssh/config





https://www.r-bloggers.com/password-protect-shiny-apps/
            
Files:
    
sudo emacs /etc/apache2/sites-enabled/000-default.conf
sudo emacs /etc/nginx/nginx.conf
sudo emacs /etc/shiny-server/shiny-server.conf

cat /var/log/nginx/error.log


/etc/init.d/apache2 restart
sudo service nginx start
sudo service nginx stop

sudo service nginx restart
sudo service shiny-server start

sudo service shiny-server stop

Job for nginx.service failed because the control process exited with error code.
See "systemctl status nginx.service" and "journalctl -xe" for details.





systemctl status nginx.service
● nginx.service - A high performance web server and a reverse proxy server
   Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
   Active: failed (Result: exit-code) since Mon 2017-07-24 11:35:02 CEST; 42s ago
     Docs: man:nginx(8)
  Process: 15895 ExecStart=/usr/sbin/nginx -g daemon on; master_process on; (code=exited, status=1/FAILURE)
  Process: 15892 ExecStartPre=/usr/sbin/nginx -t -q -g daemon on; master_process on; (code=exited, status=0/SUCCESS)

Jul 24 11:34:59 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:00 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:00 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:01 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:01 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:02 salambo2 nginx[15895]: nginx: [emerg] still could not bind()
Jul 24 11:35:02 salambo2 systemd[1]: nginx.service: Control process exited, code=exited status=1
Jul 24 11:35:02 salambo2 systemd[1]: Failed to start A high performance web server and a reverse proxy server.
Jul 24 11:35:02 salambo2 systemd[1]: nginx.service: Unit entered failed state.
Jul 24 11:35:02 salambo2 systemd[1]: nginx.service: Failed with result 'exit-code'.








journalctl -xe


-- Support: https://www.debian.org/support
-- 
-- Unit ssh.service has finished starting up.
-- 
-- The start-up result is done.
Jul 24 11:16:45 salambo2 /usr/lib/gdm3/gdm-x-session[1335]: ATTENTION: default value of option force_s3tc_enable overridden by
Jul 24 11:17:01 salambo2 CRON[15645]: pam_unix(cron:session): session opened for user root by (uid=0)
Jul 24 11:17:01 salambo2 CRON[15646]: (root) CMD (   cd / && run-parts --report /etc/cron.hourly)
Jul 24 11:17:01 salambo2 CRON[15645]: pam_unix(cron:session): session closed for user root
Jul 24 11:20:25 salambo2 kernel: perf: interrupt took too long (6170 > 6152), lowering kernel.perf_event_max_sample_rate to 32
Jul 24 11:29:45 salambo2 xfce4-terminal[2465]: Allocating size to GtkScrollbar 0x56533403a990 without calling gtk_widget_get_p
Jul 24 11:34:08 salambo2 xfce4-terminal[2465]: Allocating size to GtkScrollbar 0x56533403a590 without calling gtk_widget_get_p
Jul 24 11:34:11 salambo2 xfce4-terminal[2465]: Allocating size to GtkScrollbar 0x56533403a590 without calling gtk_widget_get_p
Jul 24 11:34:14 salambo2 su[3765]: pam_unix(su:session): session closed for user shiny
Jul 24 11:34:27 salambo2 sudo[15802]:     root : TTY=pts/1 ; PWD=/home/amartinezp/SparkleShare/personal/salud/tracksGPS ; USER
Jul 24 11:34:27 salambo2 sudo[15802]: pam_unix(sudo:session): session opened for user root by root(uid=0)
Jul 24 11:34:28 salambo2 sudo[15802]: pam_unix(sudo:session): session closed for user root
Jul 24 11:34:46 salambo2 sudo[15833]:     root : TTY=pts/1 ; PWD=/home/amartinezp/SparkleShare/personal/salud/tracksGPS ; USER
Jul 24 11:34:46 salambo2 sudo[15833]: pam_unix(sudo:session): session opened for user root by root(uid=0)
Jul 24 11:34:46 salambo2 sudo[15833]: pam_unix(sudo:session): session closed for user root
Jul 24 11:34:59 salambo2 sudo[15862]:     root : TTY=pts/1 ; PWD=/home/amartinezp/SparkleShare/personal/salud/tracksGPS ; USER
Jul 24 11:34:59 salambo2 sudo[15862]: pam_unix(sudo:session): session opened for user root by root(uid=0)
Jul 24 11:34:59 salambo2 systemd[1]: Starting A high performance web server and a reverse proxy server...
-- Subject: Unit nginx.service has begun start-up
-- Defined-By: systemd
-- Support: https://www.debian.org/support
-- 
-- Unit nginx.service has begun starting up.
Jul 24 11:34:59 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:00 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:00 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:01 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:01 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:02 salambo2 nginx[15895]: nginx: [emerg] still could not bind()
Jul 24 11:35:02 salambo2 systemd[1]: nginx.service: Control process exited, code=exited status=1
Jul 24 11:35:02 salambo2 systemd[1]: Failed to start A high performance web server and a reverse proxy server.
-- Subject: Unit nginx.service has failed
-- Defined-By: systemd
-- Support: https://www.debian.org/support
-- 
-- Unit nginx.service has failed.
-- 
-- The result is failed.
Jul 24 11:35:02 salambo2 systemd[1]: nginx.service: Unit entered failed state.
Jul 24 11:35:02 salambo2 systemd[1]: nginx.service: Failed with result 'exit-code'.
Jul 24 11:35:02 salambo2 sudo[15862]: pam_unix(sudo:session): session closed for user root
Jul 24 11:35:17 salambo2 xfce4-terminal[2465]: Allocating size to GtkScrollbar 0x56533403a590 without calling gtk_widget_get_p
Jul 24 11:35:17 salambo2 xfce4-terminal[2465]: Allocating size to GtkScrollbar 0x56533403a590 without calling gtk_widget_get_p

-- Unit nginx.service has begun starting up.
Jul 24 11:34:59 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:00 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:00 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:01 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:01 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:02 salambo2 nginx[15895]: nginx: [emerg] still could not bind()
Jul 24 11:35:02 salambo2 systemd[1]: nginx.service: Control process exited, code=exited status=1
Jul 24 11:35:02 salambo2 systemd[1]: Failed to start A high performance web server and a reverse proxy server.
-- Subject: Unit nginx.service has failed
-- Defined-By: systemd
-- Support: https://www.debian.org/support
-- 
-- Unit nginx.service has failed.
-- 
-- The result is failed.
Jul 24 11:35:02 salambo2 systemd[1]: nginx.service: Unit entered failed state.
Jul 24 11:35:02 salambo2 systemd[1]: nginx.service: Failed with result 'exit-code'.
Jul 24 11:35:02 salambo2 sudo[15862]: pam_unix(sudo:session): session closed for user root
Jul 24 11:35:17 salambo2 xfce4-terminal[2465]: Allocating size to GtkScrollbar 0x56533403a590 without calling gtk_widget_get_p
Jul 24 11:35:17 salambo2 xfce4-terminal[2465]: Allocating size to GtkScrollbar 0x56533403a590 without calling gtk_widget_get_p-- Unit nginx.service has begun starting up.
Jul 24 11:34:59 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:00 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:00 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:01 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:01 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:02 salambo2 nginx[15895]: nginx: [emerg] still could not bind()
Jul 24 11:35:02 salambo2 systemd[1]: nginx.service: Control process exited, code=exited status=1
Jul 24 11:35:02 salambo2 systemd[1]: Failed to start A high performance web server and a reverse proxy server.
-- Subject: Unit nginx.service has failed
-- Defined-By: systemd
-- Support: https://www.debian.org/support
-- 
-- Unit nginx.service has failed.
-- 
-- The result is failed.
Jul 24 11:35:02 salambo2 systemd[1]: nginx.service: Unit entered failed state.
Jul 24 11:35:02 salambo2 systemd[1]: nginx.service: Failed with result 'exit-code'.
Jul 24 11:35:02 salambo2 sudo[15862]: pam_unix(sudo:session): session closed for user root
Jul 24 11:35:17 salambo2 xfce4-terminal[2465]: Allocating size to GtkScrollbar 0x56533403a590 without calling gtk_widget_get_p
Jul 24 11:35:17 salambo2 xfce4-terminal[2465]: Allocating size to GtkScrollbar 0x56533403a590 without calling gtk_widget_get_p




-- Unit nginx.service has begun starting up.
Jul 24 11:34:59 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:00 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:00 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:01 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:01 salambo2 nginx[15895]: nginx: [emerg] listen() to 0.0.0.0:80, backlog 511 failed (98: Address already in use)
Jul 24 11:35:02 salambo2 nginx[15895]: nginx: [emerg] still could not bind()
Jul 24 11:35:02 salambo2 systemd[1]: nginx.service: Control process exited, code=exited status=1
Jul 24 11:35:02 salambo2 systemd[1]: Failed to start A high performance web server and a reverse proxy server.
-- Subject: Unit nginx.service has failed
-- Defined-By: systemd
-- Support: https://www.debian.org/support
-- 
-- Unit nginx.service has failed.
-- 
-- The result is failed.
Jul 24 11:35:02 salambo2 systemd[1]: nginx.service: Unit entered failed state.
Jul 24 11:35:02 salambo2 systemd[1]: nginx.service: Failed with result 'exit-code'.
Jul 24 11:35:02 salambo2 sudo[15862]: pam_unix(sudo:session): session closed for user root
Jul 24 11:35:17 salambo2 xfce4-terminal[2465]: Allocating size to GtkScrollbar 0x56533403a590 without calling gtk_widget_get_p
Jul 24 11:35:17 salambo2 xfce4-terminal[2465]: Allocating size to GtkScrollbar 0x56533403a590 without calling gtk_widget_get_p
