FROM iamliamnorton/ruby
MAINTAINER Liam Norton

RUN apk update && apk upgrade \
  && apk add --update nodejs postgresql-dev yaml-dev \
  && rm -rf /var/cache/apk/*

ENV APP_HOME /srv/app/
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile $APP_HOME
COPY Gemfile.lock $APP_HOME

RUN bundle install --system

COPY . $APP_HOME

VOLUME $APP_HOME/log

EXPOSE 3000/tcp

CMD rails server --port=3000 --binding=0.0.0.0
