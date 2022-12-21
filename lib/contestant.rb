class Contestant
  attr_reader :first_name, :last_name, 
              :age, :state_of_residence,
              :spending_money, :game_interests
  def initialize(attributes)
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @age = attributes[:age]
    @state_of_residence = attributes[:state_of_residence]
    @spending_money = attributes[:spending_money]
    @game_interests = []
  end

  def out_of_state? 
    @state_of_residence != 'CO'
  end

  def full_name 
    "#{first_name} #{last_name}"
  end

  def add_game_interest(game_name)
    @game_interests << game_name
  end
end