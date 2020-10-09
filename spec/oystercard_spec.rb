require 'oystercard'

describe Oystercard do
  let(:station) { double :station }
  subject(:card) { Oystercard.new }
  
  describe "#initialize" do
    it "initialized cards should have a balance of 0" do
      expect(card.balance).to eq 0
    end
  end

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do
      card.top_up(10)
      expect(card.balance).to eq(10)
    end

    it 'raises error if the max-balance is exceeded' do 
      card.top_up(90)
      expect { card.top_up 1}.to raise_error "Max balance of #{Oystercard::DEFAULT_MAX} is exceeded"
    end 
  end

  it 'is not in transit' do
    expect(card.in_journey?).to eq(false)
  end

  it 'it activates the card when touched in' do
    card.top_up(10)
    card.touch_in(:station)
    expect(card.in_journey?).to eq(true)
  end

  it 'it deactivates the card when touched out' do 
    card.top_up(10)
    card.touch_in(:station)
    card.touch_out(:station)
    expect(card.in_journey?).to eq(false)
  end

  it 'would raise error if balance is below minimum fare' do 
    expect { card.touch_in(:station) }.to raise_error "Insufficient funds: Balance less than #{Oystercard::MINIMUM_FARE}"
  end

  it 'deducts minimum fare when touching out' do
    card.top_up(10)
    card.touch_in(:station)
    expect { card.touch_out(:station) }.to change { card.balance }.by -Oystercard::MINIMUM_FARE
  end

  it 'knows the entry station' do
    card.top_up(10)

    expect { card.touch_in(:station)}.to change { card.entry_station}.to eq :station
  
  end

  it 'updates entry station to nil on touch out' do 
    card.top_up(10)
    card.touch_in(:station)
    expect { card.touch_out(:station) }.to change { card.entry_station}.to eq nil
  end

  it 'has a journey history' do
    expect(card.journey_history).to eq []
  end

  it 'knows the exit station' do
    card.top_up(10)
    card.touch_in(:station)
    card.touch_out(:station)
    expect(card.exit_station).to eq :station
  end

  it 'stores one journey as a hash' do
    card.top_up(10)
    card.touch_in('Bank')
    card.touch_out('Fulham')
    expect(card.journey_history).to eq [{entry_station: 'Bank', exit_station: 'Fulham'}]
  end

end 