upstream fastcgi_backendklinq {
    # socket
    server   unix:/var/run/php/php7.4-fpm.sock;
    # use tcp connection
    #  server  127.0.0.1:9000;
   
}

server {
    listen 80; #reuseport
    server_name local.klinq.com;

    set $MAGE_ROOT /var/www/local.klinq.com;

     set $MAGE_MODE developer;
#    set $MAGE_MODE default;
#    set $MAGE_MODE production;

    include /var/www/local.klinq.com/nginx.conf.sample;
    fastcgi_read_timeout 3000;

    access_log /var/log/nginx/klinq-access.log;
    error_log /var/log/nginx/klinq-error.log error;
}
