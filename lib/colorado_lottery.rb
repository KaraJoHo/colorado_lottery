class ColoradoLottery 
  attr_reader :registered_contestants, :winners, :current_contestants, :collect_contestants

  def initialize
    @registered_contestants = {}
    @winners = []
    @current_contestants = {}
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

  def eligible_contestants(game)

    registered_contestants[game.name].find_all do |contestant| 
      contestant.spending_money >= game.cost 
    end
  #   @registered_contestants.flat_map do |game_name, contestant|
  #     if game.name == game_name 
  #       #require 'pry'; binding.pry
  #       if registered_contestants.has_value?(contestant) && contestant.select {|cont| cont.spending_money >= game.cost}
  #         contestant
  #       end
  #     end
  #   end.compact
   end

  def charge_contestants(game)
    @current_contestants[game] = []

    eligible_contestants(game).each do |contestant|

       contestant.spending_money -= game.cost #if contestant.spending_money >= game.cost
       current_contestants[game] << contestant.full_name 
    end
  end
end