require 'sinatra'
require 'json'
require 'sinatra/cross_origin'
require "sinatra/json"
require 'pry-byebug'

class ApplicationController < Sinatra::Base
	configure do
		enable :cross_origin
	end

	before do
		response.headers['Access-Control-Allow-Origin'] = '*'
	end

	options "*" do
		response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
		response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
	end

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

	# GETS all ingredients
	get '/ingredients' do
		@ingredients = Ingredient.all

		return @ingredients.to_json
	end

	# CREATE ingredient
	post '/ingredients' do
		params = JSON.parse(request.body.read)

		newIngredient = Ingredient.new(name: params['ingredient']['name'])

		begin
			if newIngredient.save
				return newIngredient.to_json
			end
		rescue ActiveRecord::RecordNotUnique => e
			error = {
				"message": "Failed to save to database.",
				"error": e.message.to_json,
				"status": 500
			}.to_json
			halt 500, error
		end
	end

end