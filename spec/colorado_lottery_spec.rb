require './lib/game'
require './lib/contestant'
require './lib/colorado_lottery'

RSpec.describe ColoradoLottery do 
  let(:lottery) {ColoradoLottery.new}

  let(:pick_4) {Game.new('Pick 4', 2)}
  let(:mega_millions) {Game.new('Mega Millions', 5, true)}
  let(:cash_5) {Game.new('Cash 5', 1)}\

  let(:alexander) {Contestant.new({first_name: 'Alexander',
                                      last_name: 'Aigiades',
                                      age: 28,
                                      state_of_residence: 'CO',
                                      spending_money: 10})}
  let(:benjamin) {Contestant.new({
                       first_name: 'Benjamin',
                       last_name: 'Franklin',
                       age: 17,
                       state_of_residence: 'PA',
                       spending_money: 100})}
  let(:frederick) {Contestant.new({
                       first_name:  'Frederick',
                       last_name: 'Douglass',
                       age: 55,
                       state_of_residence: 'NY',
                       spending_money: 20})}
  let(:winston) {Contestant.new({
                     first_name: 'Winston',
                     last_name: 'Churchill',
                     age: 18,
                     state_of_residence: 'CO',
                     spending_money: 5})}  
  let(:grace) {Contestant.new({
                     first_name: 'Grace',
                     last_name: 'Hopper',
                     age: 20,
                     state_of_residence: 'CO',
                     spending_money: 20})}                   
  describe '#initialize' do 
    it 'exists and has attributes' do 
      expect(lottery).to be_a(ColoradoLottery)
      expect(lottery.registered_contestants).to eq({})
      expect(lottery.winners).to eq([])
      expect(lottery.current_contestants).to eq({})
    end
  end

  describe '#interested_and_18? and #can_register?' do 
    it 'checks if the contestant is interested in the game and 18 or older' do 

      alexander.add_game_interest('Pick 4')
      alexander.add_game_interest('Mega Millions')

      frederick.add_game_interest('Mega Millions')

      winston.add_game_interest('Cash 5')
      winston.add_game_interest('Mega Millions')

      benjamin.add_game_interest('Mega Millions')

      expect(lottery.interested_and_18?(alexander, pick_4)).to eq(true)
      expect(lottery.interested_and_18?(benjamin, mega_millions)).to eq(false)
      expect(lottery.interested_and_18?(alexander, cash_5)).to eq(false)

      expect(lottery.can_register?(alexander, pick_4)).to eq(true)
      expect(lottery.can_register?(alexander, cash_5)).to eq(false)
      expect(lottery.can_register?(frederick, mega_millions)).to eq(true)
      expect(lottery.can_register?(benjamin, mega_millions)).to eq(false)
      expect(lottery.can_register?(frederick, cash_5)).to eq(false)
    end
  end

  describe '#register_contestant' do 
    it 'registers teh contestants with the game name and the contestants who can register for that game' do 
      alexander.add_game_interest('Pick 4')
      alexander.add_game_interest('Mega Millions')

      frederick.add_game_interest('Mega Millions')

      winston.add_game_interest('Cash 5')
      winston.add_game_interest('Mega Millions')

      benjamin.add_game_interest('Mega Millions')

      lottery.register_contestant(alexander, pick_4) 

      expect(lottery.registered_contestants).to eq({"Pick 4" => [alexander]})

      lottery.register_contestant(alexander, mega_millions) 

      expect(lottery.registered_contestants).to eq({"Pick 4" => [alexander], "Mega Millions" => [alexander]})

      lottery.register_contestant(frederick, mega_millions)
      lottery.register_contestant(winston, cash_5)
      lottery.register_contestant(winston, mega_millions)

      expected = {
                    "Pick 4" => [alexander],
                    "Mega Millions" => [alexander, frederick, winston],
                    "Cash 5" => [winston]
      }
      expect(lottery.registered_contestants).to eq(expected)

      grace.add_game_interest('Mega Millions')
      grace.add_game_interest('Cash 5')
      grace.add_game_interest('Pick 4')
      lottery.register_contestant(grace, mega_millions)
      lottery.register_contestant(grace, cash_5)
      lottery.register_contestant(grace, pick_4)

      expected2 = {
                    "Pick 4" => [alexander, grace],
                    "Mega Millions" => [alexander, frederick, winston, grace],
                    "Cash 5" => [winston, grace]
      }

      expect(lottery.registered_contestants).to eq(expected2)
    end
  end

  describe '#eligible_contestants' do 
    it 'returns a list of contestants who are registered and have enough money' do 
     alexander.add_game_interest('Pick 4')
      alexander.add_game_interest('Mega Millions')

      frederick.add_game_interest('Mega Millions')

      winston.add_game_interest('Cash 5')
      winston.add_game_interest('Mega Millions')

      benjamin.add_game_interest('Mega Millions')

      lottery.register_contestant(alexander, pick_4) 
      lottery.register_contestant(alexander, mega_millions) 
      lottery.register_contestant(frederick, mega_millions)
      lottery.register_contestant(winston, cash_5)
      lottery.register_contestant(winston, mega_millions)

      expected = {
                    "Pick 4" => [alexander],
                    "Mega Millions" => [alexander, frederick, winston],
                    "Cash 5" => [winston]
      }

      grace.add_game_interest('Mega Millions')
      grace.add_game_interest('Cash 5')
      grace.add_game_interest('Pick 4')
      lottery.register_contestant(grace, mega_millions)
      lottery.register_contestant(grace, cash_5)
      lottery.register_contestant(grace, pick_4)

      expected2 = {
                    "Pick 4" => [alexander, grace],
                    "Mega Millions" => [alexander, frederick, winston, grace],
                    "Cash 5" => [winston, grace]
      }

      expect(lottery.eligible_contestants(pick_4)).to eq([alexander, grace])
      expect(lottery.eligible_contestants(cash_5)).to eq([winston, grace])
      expect(lottery.eligible_contestants(mega_millions)).to eq([alexander, frederick, winston, grace])
    end
  end

  describe '#charge_contestant' do 
    it 'charges the eligible contestants and returns a list of contestants who have been charged' do 
      alexander.add_game_interest('Pick 4')
      alexander.add_game_interest('Mega Millions')

      frederick.add_game_interest('Mega Millions')

      winston.add_game_interest('Cash 5')
      winston.add_game_interest('Mega Millions')

      benjamin.add_game_interest('Mega Millions')

      lottery.register_contestant(alexander, pick_4) 
      lottery.register_contestant(alexander, mega_millions) 
      lottery.register_contestant(frederick, mega_millions)
      lottery.register_contestant(winston, cash_5)
      lottery.register_contestant(winston, mega_millions)

      expected = {
                    "Pick 4" => [alexander],
                    "Mega Millions" => [alexander, frederick, winston],
                    "Cash 5" => [winston]
      }

      grace.add_game_interest('Mega Millions')
      grace.add_game_interest('Cash 5')
      grace.add_game_interest('Pick 4')
      lottery.register_contestant(grace, mega_millions)
      lottery.register_contestant(grace, cash_5)
      lottery.register_contestant(grace, pick_4)

      expected2 = {
                    "Pick 4" => [alexander, grace],
                    "Mega Millions" => [alexander, frederick, winston, grace],
                    "Cash 5" => [winston, grace]
      }

      lottery.charge_contestants(cash_5) 

      expect(lottery.current_contestants).to eq({cash_5 => ["Winston Churchill", "Grace Hopper"]})
      expect(grace.spending_money).to eq(19)
      expect(winston.spending_money).to eq(4)

      lottery.charge_contestants(mega_millions)

      current_expected = {cash_5 => ["Winston Churchill", "Grace Hopper"],
                          mega_millions => ["Alexander Aigiades", "Frederick Douglass", "Grace Hopper"]}

      expect(lottery.current_contestants).to eq(current_expected)

      expect(grace.spending_money).to eq(14)
      expect(winston.spending_money).to eq(4)
      expect(alexander.spending_money).to eq(5)
      expect(frederick.spending_money).to eq(15)

    end
  end


end