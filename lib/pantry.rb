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
    collector = {}

    @recipes.each do |recipe|
      recipe.ingredients.keys.each do |ingredient|
        if collector[ingredient]
          collector[ingredient] += recipe.ingredients[ingredient]
        else
          collector[ingredient] = recipe.ingredients[ingredient]
        end
      end
    end
    collector
  end

  def print_shopping_list
    list = shopping_list
    ingredients = list.keys
    amounts = list.values

    output = ""
    ingredients.each_with_index do |ingredient, index|
      output += "* #{ingredient}: #{amounts[index]}"
      unless index == ingredients.length - 1
        output += "\n"
      end
    end
    output
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

  def what_can_i_make
    valid_recipes.map { |recipe| recipe.name }
  end

  def how_many_can_i_make
    smallest_amount_per_recipe = {}
    recipes = valid_recipes
    recipes.each do |recipe|
      smallest_amount_per_recipe[recipe.name] = recipe.ingredients.map do |ingredient, amount|
        @stock[ingredient] / amount
      end.min
    end
    smallest_amount_per_recipe
  end

  def valid_recipes
    collector = []
    @cookbook.each do |recipe|
      has_stock = recipe.ingredients.all? do |ingredient, amount|
        @stock[ingredient] >= amount
      end
      if has_stock
        collector << recipe
      end
    end
    collector
  end

end
