FROM ubuntu

RUN \
apt-get update && \
apt-get install -y nginx && \
rm /etc/nginx/sites-enabled/default && \
echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
chown -R www-data:www-data /var/lib/nginx

#this allows docker to take care of logs
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

RUN mkdir /var/www


VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/conf.d", "/var/www"]

WORKDIR /etc/nginx

COPY Sitefile /etc/nginx/sites-enabled/

COPY css/       /var/www/css
COPY js/        /var/www/js
COPY lib/       /var/www/lib
COPY plugin/    /var/www/plugin
COPY index.html /var/www/

CMD ["nginx"]

EXPOSE 80

