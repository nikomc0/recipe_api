require 'sinatra'
require 'json'
require 'sinatra/cross_origin'
require "sinatra/json"

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

	# CREATES a new recipe
	post '/recipe' do
		params = JSON.parse(request.body.read)

		recipe = Recipe.new
		recipe.name = params['recipe']

		if recipe.save
			return recipe.to_json
		else
			error = "Couldn't save recipe. Please try again."
			halt 500, error
		end
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

	# GET recipe and its ingredients
	get '/recipe/:id' do 
		recipe_id = params[:id]
		recipe_id = recipe_id.to_i
		
		recipe = Recipe.find(recipe_id)

		recipe_ingredients = RecipeIngredient.joins(:recipe, :ingredient).where(:recipe_id => recipe_id)
		current_ingredients = []
		recipe_ingredients.each do |t|
			current_ingredients.push(Ingredient.find(t.ingredient_id))
		end

		return {
			recipe: recipe,
			recipe_ingredients: recipe_ingredients,
			current_ingredients: current_ingredients
		}.to_json
	end

	post '/recipe_ingredients/:id' do
		# get the array of ingredients
		recipe_id = params['id'].to_i
		body = JSON.parse(request.body.read)

		# does the ingredient already exist?
		to_save = body['ingredients'].filter do |t|
			if !recipe_ingredient_exists?(recipe_id, t['id'])
				# save the ingredients into recipe ingredients
				RecipeIngredient.create(recipe_id: recipe_id, ingredient_id: t['id'])
			end
		end

		status 200
	end

	def recipe_ingredient_exists?(recipe_id, ingredient_id)
		sql = "SELECT * FROM recipe_ingredients
				WHERE recipe_id = #{recipe_id}
				AND ingredient_id = #{ingredient_id};"

		result = ActiveRecord::Base.connection.exec_query(sql)

		if result.rows.length > 0
			return true
		else
			return false
		end
	end
end