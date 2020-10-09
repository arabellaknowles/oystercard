require 'station'

describe Station do
  subject(:station) {Station.new('Bank', 1) }

  it 'is created with a @name' do
    expect(station.name).to eq 'Bank'
  end

  it 'is created with a @zone' do
    expect(station.zone).to eq 1
  end

end

