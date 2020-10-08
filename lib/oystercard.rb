class Oystercard
  attr_accessor :balance, :entry_station, :journey_history, :exit_station
  DEFAULT_MAX = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(cash)
    raise "Max balance of #{DEFAULT_MAX} is exceeded" if over_max_balance?(cash)

    add_money(cash)
  end

  def in_journey?
    @entry_station != nil 
  end

  def touch_in(station)
    #check_balance - oystercard class
    fail "Insufficient funds: Balance less than #{MINIMUM_FARE}" if @balance < MINIMUM_FARE
    @entry_station = station
  end 

  def touch_out(station)
    deduct_money(MINIMUM_FARE)
    @exit_station = station
    @entry_station = nil
  end

  private

  def deduct_money(fare)
    @balance -= fare 
  end

  def add_money(cash)
    @balance += cash
  end

  def over_max_balance?(cash)
    (cash + balance) > DEFAULT_MAX
  end

end