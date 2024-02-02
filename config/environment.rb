require 'sinatra'
require 'bundler'
require 'pry'
require 'yaml'
require 'dotenv'

Bundler.require
Dotenv.load('.env')

configure :development do
    set :database, {
        adapter: ENV['PG_ADAPTER'],
        database: ENV['PG_DATABASE'],
        pool: ENV['PG_POOL'],
        host: ENV['PG_HOST'],
        port: ENV['PG_PORT'],
        username: ENV['PG_USERNAME'],
        password: ENV['PG_PASSWORD']
    }
end

require_all 'app'