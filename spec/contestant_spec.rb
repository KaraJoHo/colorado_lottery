require './lib/game'
require './lib/contestant'

RSpec.describe Contestant do 
  let(:pick_4) {Game.new('Pick 4', 2)}
  let(:mega_millions) {Game.new('Mega Millions', 5, true)}

  let(:alexander) {Contestant.new({first_name: 'Alexander',
                                      last_name: 'Aigiades',
                                      age: 28,
                                      state_of_residence: 'CO',
                                      spending_money: 10})}
  describe '#initialize' do 
    it 'exists and has attributes' do 
      expect(alexander.full_name).to eq('Alexander Aigiades')
      expect(alexander.age).to eq(28)
      expect(alexander.spending_money).to eq(10)
      expect(alexander.out_of_state?).to eq(false)
      expect(alexander.game_interests).to eq([])
    end
  end
end