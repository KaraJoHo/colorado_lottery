class ColoradoLottery 
  attr_reader :registered_contestants, :winners, :current_contestants, :date, :all_games

  def initialize 
    @registered_contestants = {}
    @winners = []
    @current_contestants = {}
    @eligible_to_play = []
    @date = Time.new
    @all_games = []
  end

  def interested_and_18?(contestant, game)
    (contestant.age >= 18) && (contestant.game_interests.include?(game.name)) && (contestant.out_of_state? == false || game.national_drawing? == true) 
  end

  def can_register?(contestant, game)
    interested_and_18?(contestant, game)
  end

  def register_contestant(contestant, game)
    if @registered_contestants[game.name] == nil 
      @registered_contestants[game.name] = []
    end
    @registered_contestants[game.name] << contestant
   
    @register_contestant
  end

  def eligible_contestants(game)
    @registered_contestants[game.name].find_all do |contestant| 
      contestant.spending_money >= game.cost
    end
  end

  def charge_contestants(game)
    @current_contestants[game] = []
    eligible_contestants(game).each do |contestant| 
      #require 'pry'; binding.pry
      contestant.charge(game.cost)
      @current_contestants[game] << contestant.full_name
      
    end
    @current_contestants
    # require 'pry'; binding.pry
  end

  def draw_winners
   @all_games.map do |game| 
    @winners << {charge_contestants(game).rand.full_name => game.name}
   end
   # make array with a random contestant from the charged contestants
   #array..
    date.strftime('%Y-%m-%d')
  end

  def add_game(game)
    @all_games << game
  end

  # def announce_winner(game_name)
  #   @winners.map do |winner| 
  #     if winner.values.include?(game_name)
  #       "#{winner.keys.pop} won the #{game_name} on #{draw_winners}"
  #     end
  #   end
  # end

end