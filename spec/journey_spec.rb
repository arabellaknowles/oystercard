require 'journey'

describe Journey do
  subject(:journey) { Journey.new }

  it 'is created with an entry station' do
    expect(journey.entry_station).to eq nil
  end

  it 'is created with an exit station' do
    expect(journey.exit_station).to eq nil
  end

  it 'changes entrance station to station input' do
    journey.start('bank')
    expect(journey.entry_station).to eq('bank')
  end

  it 'changes exit station to station input' do
    journey.finish('fulham')
    expect(journey.exit_station).to eq('fulham')
  end

  it 'returns journey is complete' do
    journey.start('bank')
    journey.finish('fulham')
    expect(journey).to be_complete
  end

  it 'calculates fare of £1 when journey is completed' do
    journey.start('bank')
    journey.finish('fulham')
    expect(journey.fare).to eq Journey::MINIMUM_FARE
  end

  it 'calculates fare of £6 when journey is incomplete' do
    journey.start('bank')
    expect(journey.fare).to eq Journey::PENALTY_CHARGE
  end

end
