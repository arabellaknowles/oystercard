require 'journey'

describe Journey do
  subject(:journey) { Journey.new }
  it 'is created with an entry station' do
    expect(journey.entry_station).to eq nil
  end

  it 'is created with an exit station' do
    expect(journey.exit_station).to eq nil
  end
end
