class CreateRecipeIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table   :recipe_ingredients do |t|
      t.belongs_to :recipe
      t.belongs_to :ingredient
      t.integer    :qty
      t.integer    :measure
    end
  end
end
