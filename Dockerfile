FROM arm64v8/php:7.4-apache


# Instalar extensiones necesarias para PHP y otras dependencias
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libzip-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mbstring zip mysqli pdo pdo_mysql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Clona el repositorio de MaNGOSWebV4
RUN git clone https://github.com/knals/MaNGOSWebV4.git . \
    && mv * /var/www/html/ && rm -rf /var/www/html/.git

# Cambiar permisos para el directorio de trabajo
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Exponer el puerto 80 para Apache
EXPOSE 82

# Iniciar el servidor Apache
CMD ["apache2-foreground"]
