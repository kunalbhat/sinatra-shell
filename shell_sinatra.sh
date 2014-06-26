#!/bin/sh

# shell_sinatra - a shell script that generates all the folders and files
# needed for a small sinatra project

# Create the root project folder
if [ "$1" != "" ]; then
  project_folder=$1
else
  project_folder='new-sinatra-project'
fi

mkdir $1

cd $1

# Initialize git
git init

# Detect explicit ruby version to set with rbenv, otherwise just
# use `system`
if [ "$2" != "" ]; then
  rbenv local $2
else
  rbenv local system
fi

# Make directories
directories=( "assets" "assets/javascripts" "views" )

for f in "${directories[@]}"
do
  :
  mkdir $f
done

# Create app files
app_files=( "app.rb Gemfile Procfile" )

for f in "${app_files[@]}"
do
  :
  touch $f
done

# Create layout and asset files
layout_files=( "assets/javascripts/application.coffee" "views/layout.haml" "views/index.haml" "style.scss" )

for f in "${layout_files[@]}"
do
  :
  touch $f
done

# Generate app.rb
cat > app.rb << _EOF_
Bundler.require :web
Bundler.require :development if development?

use Rack::Coffee, root: 'assets', urls: '/javascripts'

get '/style.css' do
  scss :style
end

get '/' do
  haml :index
end
_EOF_

# Generate Gemfile
cat > Gemfile << _EOF_
source 'https://rubygems.org'

ruby '$2'

gem 'puma'

group :web do
  gem 'haml'
  gem 'rack-coffee'
  gem 'sinatra'
  gem 'sass'
end

group :development do
  gem 'sinatra-reloader'
end
_EOF_

# Procfile
cat > Procfile << _EOF_
web: bundle exec ruby app.rb -p \$PORT
_EOF_

# Bundle
# bundle install --path vendor/
