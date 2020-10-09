require 'oystercard.rb'

class TrainBarrier
  attr_reader :card
  MINIMUM_FARE = 1

  def initialize
    @activated = false
    @card = Oystercard.new
  end

  

 

end