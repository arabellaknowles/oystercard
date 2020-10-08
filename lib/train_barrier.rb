require 'oystercard.rb'

class TrainBarrier
  attr_reader :card
  MINIMUM_FARE = 1

  def initialize
    @activated = false
    @card = Oystercard.new
  end

  def in_journey?
    @activated 
  end

  def touch_in
    #check_balance - oystercard class
    fail "Insufficient funds: Balance less than #{MINIMUM_FARE}" if @card.balance < MINIMUM_FARE

    @activated = true
  end 

  def touch_out
    @card.balance -= MINIMUM_FARE

    @activated = false
  end

end