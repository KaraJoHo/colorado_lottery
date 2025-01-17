class Game 
  attr_reader :name, :cost, :national_drawing

  def initialize(name, cost, national_drawing = nil)
    @name = name 
    @cost = cost
    @national_drawing = national_drawing
  end

  def national_drawing? 
    if @national_drawing == nil 
      false 
    else 
      @national_drawing
    end
  end
end