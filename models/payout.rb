class Payout
  attr_reader :players, :money_map

  def initialize(players)
    @players = players
    @money_map = {}
    @players.each do |payer|
      @players.each do |payee|
        if payer != payee
          @money_map[key(payer, payee)] = {
            :payer => payer,
            :payee => payee,
            :amount => BigDecimal.new('0')
          }
        end
      end
    end
  end

  def owes(payer, payee, amount)
    @money_map[key(payer, payee)][:amount] += amount
  end

  def owed(payer, payee)
    entry = @money_map[key(payer, payee)]
    return entry ? entry[:amount] : BigDecimal.new('0')
  end

  def add_points(player_points, price_per_point)
    @players.each do |payer|
      @players.each do |payee|
        if payer != payee
          points = BigDecimal.new(player_points[payee])
          owes(payer, payee, price_per_point * points)
        end
      end
    end
    return self
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

  def to_s
    result = 'Payer On Top'.center((@players.size + 1) * 15 + 6)
    result << "\n"
    result << ' '  * 21
    @players.each do |player|
      result << player.name.rjust(15)
    end
    result << "\n"
    @players.each do |payer|
      result << payer.name.rjust(15) + ' owes:'
      @players.each do |payee|
        if payer != payee
          result << owed(payer, payee).to_s('2F').rjust(15)
        else
          result << ''.rjust(15)
        end
      end
      result << "\n"
    end
    return result
  end

  private

  def key(payer, payee)
    return payer.symbol + ':' + payee.symbol
  end
end
