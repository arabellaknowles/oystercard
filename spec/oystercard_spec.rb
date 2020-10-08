require 'oystercard'

describe Oystercard do
  let(:station) { double :station }

  it "initialized cards should have a balance of 0" do
    expect(subject.balance).to eq 0
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

  it 'can top up the balance' do
    subject.top_up(10)
    expect(subject.balance).to eq(10)
  end

  it 'raises error if the max-balance is exceeded' do 
    subject.top_up(90)
    expect { subject.top_up 1}.to raise_error "Max balance of #{Oystercard::DEFAULT_MAX} is exceeded"
  end 

  it 'is not in transit' do
    expect(subject.in_journey?).to eq(false)
  end

  it 'it activates the card when touched in' do
    subject.top_up(10)
    subject.touch_in(:station)
    expect(subject.in_journey?).to eq(true)
  end

  it 'it deactivates the card when touched out' do 
    subject.top_up(10)
    subject.touch_in(:station)
    subject.touch_out(:station)
    expect(subject.in_journey?).to eq(false)
  end

  it 'would raise error if balance is below minimum fare' do 
    expect { subject.touch_in(:station) }.to raise_error "Insufficient funds: Balance less than #{Oystercard::MINIMUM_FARE}"
  end

  it 'deducts minimum fare when touching out' do
    subject.top_up(10)
    subject.touch_in(:station)
    expect { subject.touch_out(:station) }.to change { subject.balance }.by -Oystercard::MINIMUM_FARE
  end

  it 'knows the entry station' do
    subject.top_up(10)

    expect { subject.touch_in(:station)}.to change { subject.entry_station}.to eq :station
  
  end

  it 'updates entry station to nil on touch out' do 
    subject.top_up(10)
    subject.touch_in(:station)
    expect { subject.touch_out(:station) }.to change { subject.entry_station}.to eq nil
  end

  it 'has a journey history' do
    expect(subject.journey_history).to eq []
  end

  it 'knows the exit station' do
    subject.top_up(10)
    subject.touch_in(:station)
    subject.touch_out(:station)
    expect(subject.exit_station).to eq :station
  end

  it 'stores one journey as a hash' do
    subject.top_up(10)
    subject.touch_in('Bank')
    subject.touch_out('Fulham')
    expect(subject.journey_history).to eq [{entry_station: 'Bank', exit_station: 'Fulham'}]
  end

end 