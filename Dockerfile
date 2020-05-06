# based on debian stretch-slim
FROM debian:stretch-slim
MAINTAINER Ayoob G <ag@hamarilabs.com>

RUN apt-get update && \
 DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && \
 DEBIAN_FRONTEND=noninteractive apt-get -y install wget sudo pwgen apt-utils

RUN sudo apt-get install openssh-client -y
RUN apt-get install gnupg2 -y
RUN apt-get install apt-transport-https -y
RUN sudo apt install ca-certificates apt-transport-https
RUN wget -q https://packages.sury.org/php/apt.gpg -O- | sudo apt-key add -
RUN echo "deb https://packages.sury.org/php/ stretch main" | sudo tee /etc/apt/sources.list.d/php.list


RUN apt-get update

# Install selected extensions and other stuff
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get -y --no-install-recommends install \
    locales-all \
    git \
    curl \
    bzip2 \
    unzip \
    build-essential \
    autoconf \
    cabextract \
    php7.3 \
    php7.3-common \
    php7.3-curl \
    php7.3-mysql \
    php7.3-redis \
    php7.3-sqlite3 \
    php7.3-bcmath \
    php7.3-bz2 \
    php7.3-phpdbg \
    php7.3-gd \
    php7.3-json \
    php7.3-imagick \
    php7.3-imap \
    php7.3-intl \
    php7.3-ldap \
    php7.3-mbstring \
    php7.3-opcache \
    php7.3-soap \
    php7.3-ssh2 \
    php7.3-xmlrpc \
    php7.3-xml \
    php7.3-zip \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

WORKDIR /tmp

# install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

# install node & npm
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get install -y nodejs

VOLUME ["/app"]
WORKDIR /app

CMD ["php","-v"]