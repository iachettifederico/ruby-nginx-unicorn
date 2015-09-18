FROM seapy/ruby:2.2.0
MAINTAINER ChangHoon Jeong <iamseapy@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Update packages
RUN apt-get update

# Install nodejs
RUN apt-get install -qq -y nodejs

# Intall software-properties-common for add-apt-repository
RUN apt-get install -qq -y software-properties-common

# Install Nginx.
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN apt-get install -qq -y nginx
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx

# Add default nginx config
ADD nginx-sites.conf /etc/nginx/sites-enabled/default

# Install bundler
RUN gem install bundler

# Install foreman
RUN gem install foreman

# Rails App directory
WORKDIR /app
RUN mkdir -p /app/log
RUN mkdir -p /app/tmp

# Add default unicorn config
ADD unicorn.rb /app/config/unicorn.rb

# Add default foreman config
ADD Procfile /app/Procfile

# Set RODA_ENV to production
ENV ENVIRONMENT production

CMD foreman start -f Procfile
