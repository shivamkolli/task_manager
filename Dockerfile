FROM ruby:3.4.5-slim

ENV RAILS_ENV=development \
    BUNDLE_WITHOUT="" \
    BUNDLE_PATH=/usr/local/bundle

WORKDIR /app

# Install system dependencies.
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      build-essential \
      libpq-dev \
      git \
      curl \
      libyaml-dev && \
    rm -rf /var/lib/apt/lists/*

# Install Ruby dependencies first for better Docker layer caching.
COPY Gemfile Gemfile.lock ./

RUN bundle install

# Copy application source.
COPY . .

# Ensure the Rails executable can run.
RUN chmod +x bin/rails

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]