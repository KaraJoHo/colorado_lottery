class ColoradoLottery 
  attr_reader :registered_contestants, :winners, :current_contestants

  def initialize 
    @registered_contestants = {}
    @winners = []
    @current_contestants = {}
  end

  def interested_and_18?(contestant, game)
    #require 'pry'; binding.pry
    (contestant.age >= 18) && (contestant.game_interests.include?(game.name)) && (contestant.out_of_state? == false || game.national_drawing? == true) 
  end
end