# Use the official PHP image with version 8.2
FROM php:8.2.10

# Install dependencies for Laravel
RUN apt-get update -y && apt-get install -y \
    openssl \
    zip \
    unzip \
    git \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql pdo_mysql

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set the working directory inside the container
WORKDIR /app

# Copy the Laravel project files into the container
COPY ./laravel11-docker/src /app

# Run Composer to install the PHP dependencies
RUN composer install

# Expose port 8000 for Laravel
EXPOSE 8000

# Command to run Laravel development server
CMD php artisan serve --host=0.0.0.0 --port=8000
