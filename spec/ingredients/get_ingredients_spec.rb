require 'rack/test'
require_relative '../spec_helper'

describe 'GET /ingredients' do
  it 'returns a JSON response with all ingredients' do
    # Assuming you have some sample ingredients in your test database
    ingredient1 = Ingredient.create(name: 'Ingredient 1', description: 'Description 1')
    ingredient2 = Ingredient.create(name: 'Ingredient 2', description: 'Description 2')

    get '/ingredients'

    expect(last_response).to be_ok
    expect(last_response.headers['Content-Type']).to include('application/json')

    # Parse the JSON response
    ingredients_json = JSON.parse(last_response.body)

    # Check if the JSON response contains the expected ingredients
    expect(ingredients_json).to be_an(Array)
    expect(ingredients_json.length).to eq(2) # Assuming there are two ingredients

    # Check the content of the JSON response
    expect(ingredients_json[0]['name']).to eq('Ingredient 1')
    expect(ingredients_json[0]['description']).to eq('Description 1')

    expect(ingredients_json[1]['name']).to eq('Ingredient 2')
    expect(ingredients_json[1]['description']).to eq('Description 2')
  end
end
