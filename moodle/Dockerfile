
# 
# author Marc Burchart <marc.burchart@fernuni-hagen.de>
# version 1.0-20200928
# description The file which defines the whole service environment.
# 

FROM debian:bullseye

ARG MOODLE_VERSION=3.10.8
    # Moodleversion to install e. g. 3.10.8

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y

RUN apt-get install -y \
    # Curl
        curl \
    # WGET
        wget \
    # PHP
        php \
        php-pgsql \
        php-curl \
        php-zip \
        php-xml \
        php-mbstring \
        php-soap \
        php-xmlrpc \
        php-intl \
        php-gd \
        libapache2-mod-php \
    # Apache
        apache2 \
        apache2-utils \
    # Git
        git \
        gnupg2 \
    # Dialog
        dialog
# Config Apache2
RUN echo "ServerName $(ip route get 8.8.8.8 | awk '{print $NF; exit}')" >> /etc/apache2/apache2.conf
RUN sed -i -e 's/\/html//g' /etc/apache2/sites-available/000-default.conf
RUN rm -r /var/www/html

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs
RUN npm i -g grunt-cli

# Get Moodle
RUN wget https://github.com/moodle/moodle/archive/refs/tags/v${MOODLE_VERSION}.tar.gz && \
    tar -xf v${MOODLE_VERSION}.tar.gz --strip-components=1 -C /var/www/ && \
    rm -rf v${MOODLE_VERSION}.tar.gz

# Create folders and set permission
RUN chown www-data:www-data /var/www
RUN mkdir /var/moodledata && chown -R www-data:www-data /var/moodledata

# Prepare SSH AND GNPG2
VOLUME /home/keys
COPY ./known_hosts /home/known_hosts

# Set entrypoint
COPY ./entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

COPY ./apache2.conf /etc/apache2

RUN chown www-data:www-data /var/www

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 80 443
CMD ["start"]