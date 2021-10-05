require 'sinatra'
require 'json'

class ApplicationController < Sinatra::Base
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