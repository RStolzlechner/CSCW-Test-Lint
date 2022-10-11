#!/bin/bash

# 
# author Marc Burchart <marc.burchart@fernuni-hagen.de>
# version 1.0-20200928
# description This script is called after the creation of the container.
# 

# Stop script immediately if a command does not exit 0.
set -e

# Check if the moodle config file exists. Otherwise create one.
if [ ! -f /var/www/config.php ]; then
    cd /var/www && \
    /usr/bin/php admin/cli/install.php \
    --lang="${MOODLE_LANG}" \
    --chmod=0777 \
    --wwwroot="${MOODLE_ADDRESS}" \
    --dataroot=/var/moodledata \
    --dbtype=pgsql \
    --dbhost=postgres \
    --dbname="${POSTGRESQL_MOODLEDB}" \
    --dbuser="${POSTGRESQL_USERNAME}" \
    --dbpass="${POSTGRESQL_PASSWORD}" \
    --fullname="${MOODLE_FULLNAME}" \
    --shortname="${MOODLE_SHORTNAME}" \
    --adminuser="${MOODLE_ADMINUSERNAME}" \
    --adminpass="${MOODLE_ADMINPASSWORD}" \
    --adminemail="${MOODLE_ADMINEMAIL}" \
    --non-interactive=true \
    --agree-license=true
    chown www-data:www-data /var/www/config.php && chmod 2644 /var/www/config.php
fi

# Prepare Git
git config --global user.name "${GIT_NAME}"
git config --global user.email "${GIT_EMAIL}"
git config --global gpg.program gpg2

# Generate ssh and gpg2
if [ ! -f ~/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -b 4096 -N "${GIT_PASSWORD}" -C "${GIT_EMAIL}" -f ~/.ssh/id_rsa
    mv ~/.ssh/id_rsa.pub /home/keys/ssh.pub
    # Increase the security
    mkdir ~/.gnupg && cd ~/.gnupg && chmod 700 ~/.gnupg
    chown -R $(whoami) ~/.gnupg/
    # Solve: [stdin]: sign+encrypt failed: Inappropriate ioctl for device
    touch ~/.gnupg/gpg.conf
    echo "use-agent" >> ~/.gnupg/gpg.conf
    echo "pinentry-mode loopback" >> ~/.gnupg/gpg.conf    

cat >keydetails <<EOF
    %echo Generating a basic OpenPGP key
    Key-Type: RSA
    Key-Length: 4096
    Subkey-Type: RSA
    Subkey-Length: 4096
    Name-Real: user1
    Name-Comment: ${GIT_NAME}
    Name-Email: ${GIT_EMAIL}
    Expire-Date: 0
    Passphrase: ${GIT_PWD_GPG}    
    # Do a commit here, so that we can later print "done" :-)
    %commit
    %echo done
EOF
# Use following commands on keydetails if we dont want to have a passphrase.
#%no-ask-passphrase
#%no-protection
    gpg2 --verbose --batch --gen-key keydetails
    key=$(gpg --list-secret-keys --keyid-format LONG | awk '/sec/{if (length($2) > 0) print $2}')
    gpg2 --armor --output /home/gpg.pub --export "${key##*/}"
    mv /home/gpg.pub /home/keys/gpg.pub
    git config --global user.signingkey "${key##*/}"
    git config --global commit.gpgsign true
fi

# Finally start the webserver.
service apache2 start

# Define output of stdout.
if [ "$1" = 'start' ]; then
    FILE=/var/log/apache2/error.log
    if [ ! -f /var/log/apache2/error.log ]; then
        touch /var/log/apache2/error.log
    fi
    tail -f /var/log/apache2/error.log
else
	exec "$@"
fi