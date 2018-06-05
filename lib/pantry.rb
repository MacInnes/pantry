class Pantry
  attr_reader :stock,
              :recipes,
              :cookbook
  
  def initialize
    @stock = {}
    @recipes = []
    @cookbook = []
  end

  def restock(name, amount)
    if @stock[name]
      @stock[name] += amount
    else
      @stock[name] = amount
    end
  end

  def stock_check(name)
    return @stock[name] || 0
  end

  def add_to_shopping_list(recipe)
    @recipes << recipe
  end

  def shopping_list
    @recipes.reduce({}) do |collector, recipe|
      recipe.ingredients.keys.each do |ingredient|
        if collector[ingredient]
          collector[ingredient] += recipe.ingredients[ingredient]
        else
          collector[ingredient] = recipe.ingredients[ingredient]
        end
      end
      collector
    end
  end

  def print_shopping_list
    list = shopping_list
    ingredients = list.keys
    amounts = list.values

    ingredients.reduce("") do |collector, ingredient|
      index = ingredients.find_index(ingredient)
      collector += "* #{ingredient}: #{amounts[index]}"
      unless ingredients.last == ingredient
        collector += "\n"
      end
      collector
    end
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

  def what_can_i_make
    valid_recipes.map { |recipe| recipe.name }
  end

  def how_many_can_i_make
    recipes = valid_recipes
    recipes.reduce({}) do |collector, recipe|
      collector[recipe.name] = recipe.ingredients.map do |ingredient, amount|
        @stock[ingredient] / amount
      end.min
      collector
    end
  end

  def valid_recipes
    @cookbook.select do |recipe|
      recipe.ingredients.all? do |ingredient, amount|
        @stock[ingredient] >= amount
      end
    end
  end

end
