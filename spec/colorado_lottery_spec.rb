require './lib/contestant'
require './lib/game'
require './lib/colorado_lottery' 

RSpec.describe ColoradoLottery do 
  it 'exists and has attributes' do 
    lottery = ColoradoLottery.new 
     expect(lottery.registered_contestants).to eq({})
     expect(lottery.winners).to eq([])
     expect(lottery.current_contestants).to eq({})
  end
end