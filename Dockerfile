FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /myapp
WORKDIR /dogwalking_api
COPY Gemfile /dogwalking_api/Gemfile
COPY Gemfile.lock /dogwalking_api/Gemfile.lock
RUN bundle install
COPY . /dogwalking_api
