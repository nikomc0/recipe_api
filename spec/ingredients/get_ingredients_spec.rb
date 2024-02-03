require 'rack/test'
require_relative '../spec_helper'

describe 'GET /ingredients' do
  def app
    ApplicationController
  end

  before(:each) do 
    # Assuming you have some sample ingredients in your test database
    ingredient1 = Ingredient.create(name: 'Ingredient 1')
    ingredient2 = Ingredient.create(name: 'Ingredient 2')
  end

  after(:each) do
    ActiveRecord::Base.connection.execute('DELETE FROM ingredients;')
    ActiveRecord::Base.connection.execute('ALTER SEQUENCE ingredients_id_seq RESTART WITH 1;')
  end

  it 'returns a JSON response with all ingredients' do
    get '/ingredients'

    # Parse the JSON response
    ingredients_json = JSON.parse(last_response.body)

    # Check if the JSON response contains the expected ingredients
    expect(ingredients_json).to be_an(Array)
    expect(ingredients_json.length).to eq(2) # Assuming there are two ingredients

    # Check the content of the JSON response
    expect(ingredients_json[0]['name']).to eq('Ingredient 1')

    expect(ingredients_json[1]['name']).to eq('Ingredient 2')
  end
end
