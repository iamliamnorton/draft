FROM ruby:2.2.3
MAINTAINER Liam Norton

RUN apt-get -y update && apt-get -y upgrade && \
    apt-get -y --force-yes --no-install-recommends install build-essential libpq-dev

ENV APP_HOME /srv/app/
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile $APP_HOME
COPY Gemfile.lock $APP_HOME

RUN bundle install

COPY . $APP_HOME

VOLUME $APP_HOME/log

EXPOSE 3000/tcp

CMD rails server --port=3000 --binding=0.0.0.0
