FROM php:8.3.10-fpm-bookworm

ENV APACHE_DOCUMENT_ROOT=/var/www/app/public
ENV NVM_DIR=/usr/local/nvm
ENV NODE_VERSION=20.16.0

# Install system dependencies
RUN apt update -y && \
    apt install -y libbz2-dev zlib1g-dev libpng-dev libxml2-dev libxslt-dev libzip-dev libonig-dev zip nginx supervisor && \ 
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js using NVM
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

# Change default path
WORKDIR /var/www/app

USER www-data

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
