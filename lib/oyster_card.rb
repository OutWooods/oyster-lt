class OysterCard
  attr_reader :balance
  BALANCE_MAX = 90
  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise("Maximum balance exceeded, max is #{BALANCE_MAX}") if limit_exceeded?(amount)
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end
  
  private
  def limit_exceeded?(amount)
     balance + amount >= BALANCE_MAX
  end
end
