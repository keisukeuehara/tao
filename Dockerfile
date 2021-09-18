FROM php:7.3-apache
ENV DEBCONF_NOWARNINGS yes
RUN apt-get update && apt-get install -y default-mysql-server default-mysql-client libpng-dev libzip-dev unzip libjs-mathjax sudo
RUN docker-php-ext-install pdo_mysql mysqli gd zip opcache
RUN service mariadb start && sleep 10s && echo "GRANT ALL PRIVILEGES ON *.* TO tao@localhost IDENTIFIED BY 'taopass'; FLUSH PRIVILEGES;" | mysql
RUN sed -i '$iservice mariadb start' /usr/local/bin/apache2-foreground

RUN cd /etc/apache2/mods-enabled && ln -s ../mods-available/rewrite.load
RUN cd /tmp && curl -LO https://github.com/oat-sa/package-tao/archive/v3.3-rc02.zip && unzip v3.3-rc02.zip && mv package-tao-3.3-rc02/.htaccess package-tao-3.3-rc02/* /var/www/html
RUN chown -R www-data:www-data /var/www/html
RUN cd /tmp && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php
RUN chown -R www-data /var/www && cd /var/www/html && sudo -u www-data php /tmp/composer.phar update && sudo -u www-data php /tmp/composer.phar install
RUN cd /var/www/html && curl -OL https://github.com/oat-sa/taohub-articles/raw/master/articles/resources/third-party/MathJax_Install_TAO_3x.sh && chmod u+x MathJax_Install_TAO_3x.sh && ./MathJax_Install_TAO_3x.sh
# RUN cd /var/www/html && sudo -u www-data php tao/scripts/taoInstall.php --db_driver pdo_mysql --db_host 127.0.0.1 --db_name tao_db --db_user tao --db_pass taopass --module_namespace http://127.0.0.1/first.rdf --module_url http://127.0.0.1 --user_login tao --user_pass taopass -e taoCe


# taoをスタート
# $ docker build -t tao .
# $ docker run -d --name tao -p 80:80 tao
