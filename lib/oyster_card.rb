class OysterCard
  attr_reader :balance

  BALANCE_MAX = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "Insufficient funds available" if minimum_fare_available?
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(MIN_FARE)
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
