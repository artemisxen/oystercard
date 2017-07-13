require_relative 'journey'

class Oystercard

  DEFAULT_BALANCE = 0
  LIMIT = 90

  attr_reader :balance, :journey, :history

  def initialize(journey_class = Journey)
    @balance = 0
    @history = []
    @journey = journey_class.new
    @penalty = journey_class::PENALTY_FARE
    @minimum_fare = journey_class::MINIMUM_FARE
    @fare = @minimum_fare
  end

  def top_up(amount)
    fail "Maximum limit exceeded £#{LIMIT}" if amount + balance > LIMIT
    @balance += amount
  end

  def touch_in(station)
    finalise_journey if @journey.incomplete?
    raise "Sorry, not enough balance!" if balance < @minimum_fare
    @journey.start(station)
  end

  def touch_out(station)
    @journey.finish(station)
    finalise_journey
  end

  private

  def deduct(fare)
    @balance -= fare
  end

  def finalise_journey
    finalise_incomplete_journey if @journey.incomplete?
    deduct(@fare)
    add_journey_to_history
    @journey.reset
    @fare = @minimum_fare
  end

  def finalise_incomplete_journey
    complete_journey
    @fare = @penalty
  end

  def complete_journey
    @journey.start(nil) unless @journey.entry_station
    @journey.finish(nil) unless @journey.exit_station
  end

  def add_journey_to_history
    @history << journey
  end
end
