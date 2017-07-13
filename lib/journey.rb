class Journey
  MINIMUM_FARE = 1

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
    @journey_data[:fare]
  end
end
