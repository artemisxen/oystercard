class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @journey_data = Hash.new
  end

  def start(station)
    @journey_data[:start] = station
  end

  def entry_station
    @journey_data[:start]
  end

  def finish(station)
    @journey_data[:finish] = station
  end

  def exit_station
    @journey_data[:finish]
  end

  def fare
    @journey_data[:fare] = MINIMUM_FARE
    @journey_data[:fare] = PENALTY_FARE if incomplete?
    @journey_data[:fare]
  end

  def incomplete?
    puts "Entry station = #{entry_station.class}"
    !(entry_station && exit_station)
  end
end
