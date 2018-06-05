require './lib/pantry'
require './lib/recipe'

require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test
  
  def test_it_has_attributes
    pantry = Pantry.new
    assert_equal ({}), pantry.stock
  end

  def test_restock_adds_an_ingredient
    pantry = Pantry.new
    
    pantry.restock("Cheese", 10)
    assert_equal ({"Cheese" => 10}), pantry.stock

    pantry.restock("Cheese", 20)
    assert_equal ({"Cheese" => 30}), pantry.stock
  end

  def test_stock_check
    pantry = Pantry.new

    assert_equal 0, pantry.stock_check("Cheese")

    pantry.restock("Cheese", 10)

    assert_equal 10, pantry.stock_check("Cheese")
  end

  def test_it_can_add_recipes
    pantry = Pantry.new
    recipe = Recipe.new("Cheese Pizza")
    recipe.add_ingredient("Cheese", 20)
    recipe.add_ingredient("Flour", 20)

    pantry.add_to_shopping_list(recipe)

    assert_instance_of Recipe, pantry.recipes[0]
    assert_equal 1, pantry.recipes.length
    assert_equal ({"Cheese" => 20, "Flour" => 20}), pantry.recipes[0].ingredients
  end

  def test_it_returns_a_shopping_list
    pantry = Pantry.new
    recipe = Recipe.new("Cheese Pizza")
    recipe.add_ingredient("Cheese", 20)
    recipe.add_ingredient("Flour", 20)

    pantry.add_to_shopping_list(recipe)

    assert_equal ({"Cheese" => 20, "Flour" => 20}), pantry.shopping_list

    recipe = Recipe.new("Spaghetti")
    recipe.add_ingredient("Spaghetti Noodles", 10)
    recipe.add_ingredient("Marinara Sauce", 10)
    recipe.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(recipe)

    expected = {"Cheese" => 25, "Flour" => 20, "Spaghetti Noodles" => 10, "Marinara Sauce" => 10}

    assert_equal expected, pantry.shopping_list
  end

  def test_it_can_print_a_shopping_list
    pantry = Pantry.new
    recipe = Recipe.new("Cheese Pizza")
    recipe.add_ingredient("Cheese", 20)
    recipe.add_ingredient("Flour", 20)

    pantry.add_to_shopping_list(recipe)

    assert_equal ({"Cheese" => 20, "Flour" => 20}), pantry.shopping_list

    recipe = Recipe.new("Spaghetti")
    recipe.add_ingredient("Spaghetti Noodles", 10)
    recipe.add_ingredient("Marinara Sauce", 10)
    recipe.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(recipe)

    expected = "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"

    assert_equal expected, pantry.print_shopping_list

  end

end














