scp ./target/solar-mst-web.war  root@192.168.1.142:/home/www/solar/solar-mst-web/webapps/
ssh -t -p 22 root@192.168.1.142  "rm -rf /home/www/solar/solar-mst-web/webapps/solar-mst-web"
ssh -t -p 22 root@192.168.1.142  "chown -hR www:www /home/www/solar/solar-mst-web"

#scp ./target/solar-mst-web.war  root@192.168.1.142:/home/www/solar/solar-mst-web/webapps/
#ssh -t -p 22 root@192.168.1.143  "rm -rf /home/www/solar/solar-mst-web/webapps/solar-mst-web"
#ssh -t -p 22 root@192.168.1.143  "chown -hR www:www /home/www/solar/solar-mst-web"