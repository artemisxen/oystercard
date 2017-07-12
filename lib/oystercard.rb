class Oystercard

  DEFAULT_BALANCE = 0
  LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    #@in_journey = false
    @entry_station = nil
  end


  def top_up(amount)
    fail "Maximum limit exceeded £#{LIMIT}" if amount + balance > LIMIT
    @balance += amount
  end

  def in_journey?
     #@in_journey
     @entry_station != nil
  end

  def touch_in(station)
    raise "Sorry, not enough balance!" if balance < MINIMUM_FARE
    #@in_journey = true
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
  #  @in_journey = false
    @entry_station = nil
  end

private

def deduct(fare)
  @balance -= fare
end

end
