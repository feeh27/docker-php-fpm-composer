FROM php:7.4.4-fpm-alpine

RUN apk upgrade --update

# lib dependencies
RUN apk add --no-cache git jpeg-dev libpng-dev freetype-dev libxslt-dev icu-dev libzip-dev $PHPIZE_DEPS

# Install extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd bcmath xsl intl pdo pdo_mysql soap zip opcache

# Magento 2 required extensions
RUN docker-php-ext-install sockets

# Install Composer
RUN curl -sS https://getcomposer.org/download/1.10.13/composer.phar > composer.phar
RUN mv composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

# Install Open SSH
RUN apk add openssh

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
