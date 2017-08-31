scp -r ./target/lib root@192.168.1.142:/home/www/solar/solar-sys-service/
scp ./target/solar-sys-service.jar  root@192.168.1.142:/home/www/solar/solar-sys-service/
scp ./bin/solar-sys-service.sh  root@192.168.1.142:/home/www/solar/solar-sys-service/
ssh -t -p 22 root@192.168.1.142  "chown -hR www:www /home/www/solar/solar-sys-service"
#scp -r ./target/lib root@192.168.1.143:/home/www/solar/solar-sys-service/
#scp ./target/solar-sys-service.jar  root@192.168.1.143:/home/www/solar/solar-sys-service/
#scp ./bin/solar-sys-service.sh  root@192.168.1.143:/home/www/solar/solar-sys-service/
