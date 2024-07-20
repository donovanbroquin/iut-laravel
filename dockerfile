FROM php:8.3.9-apache-bookworm

ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
ENV NVM_DIR=/usr/local/nvm
ENV NODE_VERSION=20.15.1

# Update Apache configuration
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf && \
    sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf && \
    a2enmod rewrite

# Install system dependencies
RUN apt update -y && \
    apt install -y libbz2-dev zlib1g-dev libpng-dev libxml2-dev libxslt-dev libzip-dev libonig-dev zip && \ 
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js using NVM
RUN mkdir -p $NVM_DIR && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && \
    . $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default

# Add PHP extensions
RUN pecl install redis && \
    docker-php-ext-install mbstring exif pcntl bcmath gd zip && \
    docker-php-ext-enable redis

# Install Composer
COPY --from=composer:2.7.7 /usr/bin/composer /usr/bin/composer
