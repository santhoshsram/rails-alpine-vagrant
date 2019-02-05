#!/bin/sh

# Install the necessary packages

BUILD_PACKAGES="build-base"
DEV_PACKAGES="ruby-dev curl-dev zlib-dev libxml2-dev libxslt-dev tzdata
yaml-dev mysql-dev"
RUBY_PACKAGES="ruby ruby-io-console ruby-json ruby-bigdecimal ruby-etc yaml nodejs"
DB_PACKAGES="mysql mysql-client"
RAILS_VERSION="5.2.2"

apk add --no-cache $BUILD_PACKAGES $DEV_PACKAGES $RUBY_PACKAGES $DB_PACKAGES

# Install rails and dependencies
gem install -N bundler
gem install -N nokogiri -- --use-system-libraries
gem install -N rails --version "$RAILS_VERSION"

# Don't pull docs for gems that will be installed
# Just to keep the VM size down
echo "gem: --no-document" > ~/.gemrc
cp ~/.gemrc /etc/gemrc
chmod a+r /etc/gemrc

# The nokogiri and nokogumbo Gems has some issues building locally
# on Alpine. Set it to use the local system libraries instead
bundle config --global build.nokogiri  "--use-system-libraries"
bundle config --global build.nokogumbo "--use-system-libraries"

# Cleanup
find / -type f -iname \*.apk-new -delete
rm -rf /var/cache/apk/*
rm -rf /usr/lib/lib/ruby/gems/*/cache/*
rm -rf ~/.gem

# Configure MySQL/Mariadb
/etc/init.d/mariadb setup
rc-service mariadb start
#mysqladmin -u root -h localhost password ${DB_ROOT_PWD}
rc-update add mariadb default
