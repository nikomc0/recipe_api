require 'bundler'
require 'dotenv'

Bundler.require
Dotenv.load

env = ENV['ENVIRONMENT'].to_sym

if env == :development
	ActiveRecord::Base.establish_connection(
	  :adapter  => ENV['ADAPTER'],
	  :host     => ENV['DATABASE_HOST'],
	  :username => ENV['DATABASE_USER'],
	  :password => ENV['DATABASE_PASSWORD'],
	  :database => ENV['DATABASE_NAME']
	)
end

require_all 'app'