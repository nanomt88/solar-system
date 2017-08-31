scp -r ./target/lib root@192.168.1.142:/home/www/solar/solar-mst-service/
scp ./target/solar-mst-service.jar  root@192.168.1.142:/home/www/solar/solar-mst-service/
scp ./bin/solar-mst-service.sh  root@192.168.1.142:/home/www/solar/solar-mst-service/
ssh -t -p 22 root@192.168.1.142  "chown -hR www:www /home/www/solar/solar-mst-service"
#scp -r ./target/lib root@192.168.1.143:/home/www/solar/solar-mst-service/
#scp ./target/solar-mst-service.jar  root@192.168.1.143:/home/www/solar/solar-mst-service/
#scp ./bin/solar-mst-service.sh  root@192.168.1.143:/home/www/solar/solar-mst-service/
#ssh -t -p 22 root@192.168.1.143  "chown -hR www:www /home/www/solar/solar-mst-service"
