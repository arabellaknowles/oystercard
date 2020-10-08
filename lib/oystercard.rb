class Oystercard
  attr_accessor :balance
  DEFAULT_MAX = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @activated = false
  end

  def top_up(cash)
    raise "Max balance of #{DEFAULT_MAX} is exceeded" if over_max_balance?(cash)

    add_money(cash)
  end

  def deduct_fare(fare)
    subtract_money(fare)
  end

  def in_journey?
    @activated 
  end

  def touch_in
    #check_balance - oystercard class
    fail "Insufficient funds: Balance less than #{MINIMUM_FARE}" if @balance < MINIMUM_FARE

    @activated = true
  end 

  def touch_out
    @balance -= MINIMUM_FARE

    @activated = false
  end

  private

  def subtract_money(fare)
    @balance -= fare 
  end

  def add_money(cash)
    @balance += cash
  end

  def over_max_balance?(cash)
    (cash + balance) > DEFAULT_MAX
  end

end