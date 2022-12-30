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
  describe '#initialize' do 
    it 'exists and has attributes' do 
      expect(lottery).to be_a(ColoradoLottery)
      expect(lottery.registered_contestants).to eq({})
      expect(lottery.winners).to eq([])
      expect(lottery.current_contestants).to eq({})
    end
  end


end