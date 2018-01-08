class OysterCard
  attr_reader :balance, :entry_station, :exit_station, :journey_history

  BALANCE_MAX = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @journey_history = []
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(entry_station)
    fail "Insufficient funds available" if minimum_fare_available?
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @exit_station = exit_station
    @journey_history << {entry: entry_station, exit: exit_station}
    @entry_station = nil
  end

  def top_up(amount)
    raise("Maximum balance exceeded, max is #{BALANCE_MAX}") if limit_exceeded?(amount)
    @balance += amount
  end

  private
  def limit_exceeded?(amount)
     balance + amount >= BALANCE_MAX
  end

  def minimum_fare_available?
      balance < MIN_FARE
  end

  def deduct(fare)
    @balance -= fare
  end
end
