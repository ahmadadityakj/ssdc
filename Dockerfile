FROM ruby:2.5.5

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs
RUN apt-get update -qq && apt-get install -y postgresql-client

WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY . /app/

# Add a script to be executed every time container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["bash","entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]