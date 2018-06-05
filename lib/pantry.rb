class Pantry
  attr_reader :stock,
              :recipes
  
  def initialize
    @stock = {}
    @recipes = []
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

end
