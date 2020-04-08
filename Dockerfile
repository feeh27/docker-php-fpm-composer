FROM php:7.4.4-fpm-alpine

RUN apk upgrade --update

# lib dependencies
RUN apk add --no-cache git jpeg-dev libpng-dev freetype-dev libxslt-dev icu-dev libzip-dev $PHPIZE_DEPS

# install extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd bcmath xsl intl pdo pdo_mysql soap zip opcache \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
