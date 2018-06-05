class Pantry
  attr_reader :stock
  
  def initialize
    @stock = {}
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

end
