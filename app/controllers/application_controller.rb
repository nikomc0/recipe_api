require 'sinatra'
require 'sinatra/namespace'
require 'json'
require 'dotenv'

class ApplicationController < Sinatra::Base
	register Sinatra::Namespace
	Dotenv.load

	namespace '/v1' do
		get '/' do
			code = "<h3>API Grocery Helper</h3>"
			return code
		end

		# GETS all ingredients for recipe
		get '/recipes' do
			@recipes = Recipe.all

			return @recipes.to_json
			# erb :_recipes_list, :layout => :index
		end
	end
end