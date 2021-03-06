require 'sinatra'
require 'bundler'
require 'dotenv'
require 'yaml'

Bundler.require
Dotenv.load

configure :development do
	@config = YAML.load_file("./config/database.yml")

    set :database, @config['development']
    set :host, ENV['DATABASE_HOST']
    set :user, ENV['DATABASE_USER']
    set :password, ENV['DATABASE_PASSWORD']
end

require_all 'app'