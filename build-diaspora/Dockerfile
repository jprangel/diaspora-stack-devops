FROM ruby:2.4-slim

RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install -y \
    build-essential \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libxslt-dev \
    imagemagick \
    ghostscript \
    curl \
    libmagickwand-dev \
    git \
    libpq-dev \
    nodejs \
    wget \
    cmake \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN adduser --home /diaspora --shell /bin/sh --disabled-password --gecos "" diaspora

USER diaspora

WORKDIR /diaspora

RUN gem install bundler



EXPOSE 3000


