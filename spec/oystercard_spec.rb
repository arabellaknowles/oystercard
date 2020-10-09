require 'oystercard'

describe Oystercard do
  let(:station) { double :station }
  subject(:card) { Oystercard.new }
  
  context 'card balance is £0' do
    describe "#initialize" do
      it "initializes cards with a balance of 0" do
        expect(card.balance).to eq 0
      end
    end

    describe "#touch_in" do
      it 'would raise error if balance is below minimum fare' do 
        expect { card.touch_in(:station) }.to raise_error "Insufficient funds: Balance less than #{Oystercard::MINIMUM_FARE}"
      end
    end
  end

  context 'card balance is £10' do
    before do
      card.top_up(10)
    end
  
    describe "#top_up" do
      it 'can top up the balance' do
        expect(card.balance).to eq(10)
      end

      it 'raises error if the max-balance is exceeded' do 
        expect { card.top_up 85 }.to raise_error "Max balance of #{Oystercard::DEFAULT_MAX} is exceeded"
      end 
    end

    describe "#in_journey?" do
      it 'is not in transit when initialized' do
        expect(card.in_journey?).to eq(false)
      end

      it 'it is in journey when the card is touched in' do
        card.touch_in(:station)
        expect(card.in_journey?).to eq(true)
      end

      it 'it deactivates the card when touched out' do 
        card.touch_in(:station)
        card.touch_out(:station)
        expect(card.in_journey?).to eq(false)
      end
    end

    describe "#touch_in" do
      it 'knows the entry station' do
        expect { card.touch_in(:station) }.to change { card.entry_station }.to eq :station
      end
    end

    describe "#touch_out" do
      before do 
        card.touch_in(:station)
      end

      it 'deducts minimum fare when touching out' do
        expect { card.touch_out(:station) }.to change { card.balance }.by -Oystercard::MINIMUM_FARE
      end

      it 'updates entry station to nil on touch out' do 
        expect { card.touch_out(:station) }.to change { card.entry_station }.to eq nil
      end

      it 'knows the exit station' do
        card.touch_out(:station)
        expect(card.exit_station).to eq :station
      end
    end

    describe 'journey history' do
      it 'has an empty journey history on initialization' do
        expect(card.journey_history).to eq []
      end
  
      it 'stores one journey as a hash' do
        card.touch_in('Bank')
        card.touch_out('Fulham')
        expect(card.journey_history).to eq [{entry_station: 'Bank', exit_station: 'Fulham'}]
      end

      it 'stores multiple journeys in the journey_history array' do
        card.touch_in('Bank')
        card.touch_out('Fulham')
        card.touch_in('Pimlico')
        card.touch_out('London Fields')
        expect(card.journey_history).to eq [{entry_station: 'Fulham', exit_station: 'Bank'}, {entry_station: 'Pimlico', exit_station: 'London Fields'}]
      end
    end
  end
end