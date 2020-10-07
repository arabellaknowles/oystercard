class Oystercard
  attr_reader :balance
  DEFAULT_MAX = 90

  def initialize
    @balance = 0
  end

  def top_up(cash)
    raise "Max balance of #{DEFAULT_MAX} is exceeded" if over_max_balance?(cash)

    add_money(cash)
  end

  def deduct_fare(fare)
    subtract_money(fare)
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