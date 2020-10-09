require 'train_barrier'
require 'oystercard'

describe TrainBarrier do
  let(:trainbarrier) { TrainBarrier.new }
  let(:oystercard) { Oystercard.new }
  describe 'Sufficient funds' do 
    before do 
    end

  it 'would raise error if balance is below minimum fare' do 
    expect { trainbarrier.touch_in }.to raise_error "Insufficient funds: Balance less than #{TrainBarrier::MINIMUM_FARE}"
  end


end 