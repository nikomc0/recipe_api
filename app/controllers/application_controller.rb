require 'sinatra'
require 'json'
require 'pry-byebug'
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

	# CREATEs new recipe
	post '/recipe' do
		params = JSON.parse(request.body.read)

		@recipe = Recipe.new
		@recipe.name = params["name"]

		if @recipe.save 
			@recipe.to_json
		else
			p "Problem saving recipe."
		end
	end 
end