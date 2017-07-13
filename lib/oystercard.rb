require_relative 'journey'

class Oystercard

  DEFAULT_BALANCE = 0
  LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :journey, :history

  def initialize
    @balance = 0
    @history = []
    @journey = Journey.new
  end

  def top_up(amount)
    fail "Maximum limit exceeded £#{LIMIT}" if amount + balance > LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "Sorry, not enough balance!" if balance < MINIMUM_FARE
    @journey.start(station)
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journey.finish(station)
    @history << journey
    journey_reset
  end

  private

  def deduct(fare)
    @balance -= fare
  end

  def journey_reset
    @journey.start(nil)
    @journey.finish(nil)
  end
end
