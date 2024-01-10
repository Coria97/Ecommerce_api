FROM ruby:3.2.2
RUN mkdir -p /home/app
WORKDIR /home/app
COPY Gemfile /home/app/Gemfile
COPY Gemfile.lock /home/app/Gemfile.lock
EXPOSE 3000
RUN bundle install
COPY . /home/app
