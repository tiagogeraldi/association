# README

This is a dummy Rails 7 project created as a bad example of code to be refactored.

## Setup

```sh
asdf shell ruby 3.3.0
asdf shell nodejs 20.11.0

bundle

yarn

bundle exec rails app:update:bin

bin/rails db:create db:migrate db:seed
```


## Start the project

```sh
bin/dev
```

## Run specs

```sh
bin/rails db:create db:migrate RAILS_ENV=test

bundle exec rspec
```
