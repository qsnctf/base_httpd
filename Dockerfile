FROM httpd:2.4.57-alpine

LABEL Organization="qsnctf" Author="M0x1n <lqn@sierting.com>"

COPY files /tmp/

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.nju.edu.cn/g' /etc/apk/repositories \
    && mv /tmp/flag.sh /flag.sh \
    && mv /tmp/docker-entrypoint /usr/local/bin/docker-entrypoint \
    && mkdir -p /var/www/html \
    && mkdir -p /var/www/cgi-bin \
    && mv /tmp/testcgi.sh /var/www/cgi-bin/testcgi.sh \
    && chown -R www-data:www-data /var/www \
    && chmod 755 /var/www/cgi-bin/testcgi.sh \
    && mv -f /tmp/httpd.conf /usr/local/apache2/conf/httpd.conf \
    && chmod 644 /usr/local/apache2/conf/httpd.conf \
    && chmod +x /usr/local/bin/docker-entrypoint

WORKDIR /var/www/html

COPY www /var/www/html/

EXPOSE 80

CMD ["/bin/sh", "-c", "docker-entrypoint"]