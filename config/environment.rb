require 'sinatra'
require 'bundler'
require 'dotenv'
require 'yaml'

Bundler.require
Dotenv.load

configure :development do
    # Fix for Unknown alias: Psych since ruby 3.1+
    begin 
        @config = YAML.load_file("./config/database.yml", aliases: true)
    rescue ArgumentError
        @config = YAML.load_file("./config/database.yml")
    end

    set :database, @config['development']
    set :host, ENV['DATABASE_HOST']
    set :user, ENV['DATABASE_USER']
    set :password, ENV['DATABASE_PASSWORD']
end

require_all 'app'