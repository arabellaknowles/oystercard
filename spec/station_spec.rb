require 'station'

describe Station do

  let(:name) { double :name }
  let(:zone) { double :zone }
  subject(:station) {Station.new(:name, :zone) }

  it 'is created with a @name' do
  
    expect(station.name).to eq :name
  end

  it 'is created with a @zone' do

    expect(station.zone).to eq :zone
  end

end

