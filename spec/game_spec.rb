require './lib/game'

RSpec.describe Game do 
  let(:pick_4) {Game.new('Pick 4', 2)}
  let(:mega_millions) {Game.new('Mega Millions', 5, true)}

  describe '#initialize' do 
    it 'exists and has attributes' do 
      expect(mega_millions).to be_a(Game)
      expect(pick_4.name).to eq('Pick 4')
      expect(pick_4.cost).to eq(2)
      expect(pick_4.national_drawing?).to eq(false)
      expect(mega_millions.national_drawing?).to eq(true)
    end
  end
end