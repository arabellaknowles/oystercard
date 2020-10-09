require 'journey'

describe Journey do
  subject(:journey) { Journey.new }

  it 'is created with an entry station' do
    expect(journey.entry_station).to eq nil
  end

  it 'is created with an exit station' do
    expect(journey.exit_station).to eq nil
  end

  it { is_expected.to respond_to(:start).with(1).argument }

  it { is_expected.to respond_to(:finish).with(1).argument }

  it 'changes entrance station to station input' do
    journey.start('bank')
    expect(journey.entry_station).to eq('bank')
  end

  it 'changes exit station to station input' do
    journey.finish('fulham')
    expect(journey.exit_station).to eq('fulham')
  end
end
