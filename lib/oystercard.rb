class Oystercard
  attr_accessor :balance, :journey_history
  DEFAULT_MAX = 90
  MINIMUM_FARE = 1

  def initialize(current_journey = Journey.new)
    @balance = 0
    @journey_history = []
    @current_journey = current_journey
  end

  def top_up(cash)
    raise "Max balance of #{DEFAULT_MAX} is exceeded" if over_max_balance?(cash)

    add_money(cash)
  end

  # def in_journey?
  #   @entry_station != nil 
  # end

  def touch_in(station)
    raise "Insufficient funds: Balance less than #{MINIMUM_FARE}" if insufficient_funds
    # if current station has some value 
    # call journey.fare
    # journey.start(station)
    # @current_journey[:entry_station] = station
    # @entry_station = station

    @current_journey.start(station)
  end 

  def touch_out(station)
    deduct_money(MINIMUM_FARE)

    # if current journey doesn't have entry
    # call journey.fare
    # journey.finish(station)

    @exit_station = station
    @current_journey[:exit_station] = station
    store_journey
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

  def store_journey
    @journey_history << @current_journey
    @current_journey = {}
  end

  def insufficient_funds
    @balance < MINIMUM_FARE
  end


end