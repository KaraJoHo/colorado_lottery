class ColoradoLottery 
  attr_reader :registered_contestants, :winners, :current_contestants, :collect_contestants

  def initialize
    @registered_contestants = {}
    @winners = []
    @current_contestants ={}
  end

  def interested_and_18?(contestant, game)
    contestant.age >= 18 && contestant.game_interests.include?(game.name)
  end

  def can_register?(contestant, game)
    (interested_and_18?(contestant, game)) && (contestant.out_of_state? == false || game.national_drawing? == true)
  end

  def register_contestant(contestant, game)
    if registered_contestants[game.name] == nil 
      registered_contestants[game.name] = []
    end
      @registered_contestants[game.name] << contestant
      
    @registered_contestants
  end




end