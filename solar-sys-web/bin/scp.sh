scp ./target/solar-sys-web.war  root@192.168.1.142:/home/www/solar/solar-sys-web/webapps/
ssh -t -p 22 root@192.168.1.142  "chown -hR www:www /home/www/solar/solar-sys-web && rm -rf chown -hR www:www /home/www/solar/solar-sys-web/webapps/solar-sys-web"

#scp ./target/solar-sys-web.war  root@192.168.1.142:/home/www/solar/solar-sys-web/webapps/
#ssh -t -p 22 root@192.168.1.143  "chown -hR www:www /home/www/solar/solar-sys-web && rm -rf chown -hR www:www /home/www/solar/solar-sys-web/webapps/solar-sys-web"
