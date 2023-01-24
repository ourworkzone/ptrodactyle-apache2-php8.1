FROM ubuntu:latest

RUN apt update
RUN apt -y install software-properties-common curl apt-transport-https ca-certificates gnupg
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN DEBIAN_FRONTEND=noninteractive TZ=Asia/Kolkata apt-get -y install tzdata
RUN apt update
RUN apt update --fix-missing
RUN apt -y install php8.1
RUN apt -y install php8.1-fpm
RUN apt -y install php8.1-cli php8.1-common php8.1-gd php8.1-mysql php8.1-mbstring php8.1-bcmath php8.1-xml php8.1-curl php8.1-zip curl zip unzip apache2 wget nano tar make gcc g++ python3 python3-dev curl gnupg make gcc g++ apt-transport-https ca-certificates curl gnupg2 software-properties-common mcrypt libapache2-mod-php8.1 libapache2-mod-fcgid php8.1-xmlrpc php8.1-intl php8.1-ldap php8.1-imagick php7.4-json
RUN a2enmod proxy_fcgi setenvif ssl actions alias proxy_fcgi rewrite headers
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer


RUN usermod -u 997 www-data && groupmod -g 997 www-data



USER www-data
USER container
ENV  USER container
ENV HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
COPY ./ioncube_loader_lin_8.1.so /usr/lib/php/20210902/ioncube_loader_lin_8.1.so
COPY ./00-ioncube.ini /etc/php/8.1/fpm/conf.d/00-ioncube.ini
COPY ./php.ini /etc/php/8.1/cli/php.ini
COPY ./php.ini /etc/php/8.1/apache2/php.ini
COPY ./root //var/spool/cron/crontabs/root

CMD ["/bin/bash", "/entrypoint.sh"]