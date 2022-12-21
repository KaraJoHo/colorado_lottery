require './lib/contestant'

RSpec.describe Contestant do 
  it 'exists and has attributes' do 
    alexander = Contestant.new({first_name: 'Alexander',
                                      last_name: 'Aigiades',
                                      age: 28,
                                      state_of_residence: 'CO',
                                      spending_money: 10})
    expect(alexander).to be_a(Contestant)
    expect(alexander.state_of_residence).to eq("CO")
    expect(alexander.spending_money).to eq(10)
    expect(alexander.game_interests).to eq([])
    expect(alexander.full_name).to eq("Alexander Aigiades")
  end

  describe '#out_of_state?' do 
    it 'returns true if they are in Colorado' do 
      alexander = Contestant.new({first_name: 'Alexander',
                                      last_name: 'Aigiades',
                                      age: 28,
                                      state_of_residence: 'CO',
                                      spending_money: 10})
    
       expect(alexander.out_of_state?).to eq(false)                              
    end
  end
end