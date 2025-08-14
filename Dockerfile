FROM php:8.3-fpm

ARG user=codeacademy
ARG uid=1000

RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    # Dependências para Node.js
    gnupg2 \
    ca-certificates

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Instala extensões PHP
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd sockets

# Instala composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Instala Node.js (versão LTS atual)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest

RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

# Instala e ativa redis
RUN pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis

WORKDIR /var/www

COPY docker/php/custom.ini /usr/local/etc/php/conf.d/custom.ini

USER $user

CMD ["php-fpm"]
