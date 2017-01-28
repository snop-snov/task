FROM ruby:2.4.0

RUN apt-get update -qq && apt-get install -y build-essential postgresql libpq-dev curl

RUN apt-get install locales
RUN echo 'ru_RU.UTF-8 UTF-8' >> /etc/locale.gen
RUN locale-gen ru_RU.UTF-8
RUN dpkg-reconfigure -fnoninteractive locales
ENV LC_ALL=ru_RU.utf8
ENV LANGUAGE=ru_RU.utf8
RUN update-locale LC_ALL="ru_RU.utf8" LANG="ru_RU.utf8" LANGUAGE="ru_RU"

WORKDIR /app

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --path /bundle_cache

ADD . /app

EXPOSE 3000

CMD bundle exec rake db:create db:migrate db:seed && bundle exec rails s -b '0.0.0.0'
