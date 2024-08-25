FROM php:8.3.10-fpm-bookworm

ENV NVM_DIR=/usr/local/nvm
ENV NODE_VERSION=20.16.0

# Install system dependencies, prepare supervisord and update access for final user
RUN apt update -y && \
    apt install -y libbz2-dev zlib1g-dev libpng-dev libxml2-dev libxslt-dev libzip-dev libonig-dev zip nginx supervisor && \ 
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /var/run/supervisord && \
    chown -R www-data:www-data /var/www

# Install and prepare Node.js using NVM
RUN mkdir -p $NVM_DIR && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && \
    . $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default

ENV PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Add PHP extensions
RUN pecl install redis && \
    docker-php-ext-install -j$(nproc) mbstring exif pcntl bcmath gd zip && \
    docker-php-ext-enable redis

# Install Composer
COPY --from=composer:2.7.7 /usr/bin/composer /usr/bin/composer

# Copy base configs
COPY configs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY configs/nginx.conf /etc/nginx/sites-available/default
COPY configs/php.ini /usr/local/etc/php/conf.d/99-iut.ini

# Clean base install and prepare NGINX
RUN rm -rf /var/www/html && \
    sed -i 's|run/nginx.pid|var/run/nginx/nginx.pid|g' /etc/nginx/nginx.conf && \
    mkdir -p /var/lib/nginx/body /var/run/nginx && \
    chown -R www-data:www-data /var/lib/nginx /var/log/nginx /var/run/nginx

RUN usermod -s /bin/bash www-data

# Change default path
WORKDIR /var/www/app

# Change default user
USER www-data

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
