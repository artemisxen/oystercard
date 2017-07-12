class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance

  def initialize
    @balance = 0
    @cards = []
    @in_journey = false
  end


  def top_up(amount)
    fail "Maximum limit exceeded £#{MAXIMUM_BALANCE}" if amount + balance > MAXIMUM_BALANCE
    @balance = @balance + amount
  end

  def deduct(fare)
    @balance = @balance - fare
  end

  def in_journey?
     @in_journey
  end

  def touch_in
    raise "Sorry, not enough balance!" if balance < MINIMUM_BALANCE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end



end
