class Payout
  attr_reader :players, :money_map

  def initialize(players)
    @players = players
    @money_map = {}
    @players.each do |payer|
      @players.each do |payee|
        if payer != payee
          @money_map[key(payer, payee)] = {:payer => payer, :payee => payee, :amount => 0}
        end
      end
    end
  end

  def owes(payer, payee, amount)
    @money_map[key(payer, payee)][:amount] += amount
  end

  def owed(payer, payee)
    entry = @money_map[key(payer, payee)]
    return entry ? entry[:amount] : 0
  end

  def add_points(player_points, price_per_point)
    @players.each do |payer|
      @players.each do |payee|
        if payer != payee
          points = BigDecimal.new(player_points[payee])
          owes(payer, payee, points * price_per_point)
        end
      end
    end
  end

  def +(payout)
    total = Payout.new(@players)
    money_map.each do |key, value|
      payer = value[:payer]
      payee = value[:payee]
      total.owes(payer, payee, value[:amount])
      total.owes(payer, payee, payout.owed(payer, payee))
    end
    return total
  end

  private

  def key(payer, payee)
    return payer.symbol + ':' + payee.symbol
  end
end
