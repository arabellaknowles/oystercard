require 'oystercard'

describe Oystercard do

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

  it { is_expected.to respond_to(:deduct_fare).with(1).argument }

  it 'Does deduct fare' do 
    subject.top_up(10)
    subject.deduct_fare(6)
    expect(subject.balance).to eq(4)
  end

  it 'is not in transit' do
    expect(subject.in_journey?).to eq(false)
  end

end 