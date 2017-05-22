class PrintUtil
  def self.print_matrix(players, matrix)
    print " "  * 10
    players.each do |player|
      print player.name.rjust(10)
    end
    puts
    matrix.row_vectors.each_with_index do |row, i|
      print players[i].name.rjust(10)
      row.each do |v|
        print v.to_s.rjust(10)
      end
      puts
    end
  end

  def self.print_round_header(round_number)
    puts ("-" * 50).yellow
    print "|".yellow
    print (("Round %s" % round_number).center(48)).red
    puts "|".yellow
    puts ("-" * 50).yellow
  end

  def self.print_card_header(header)
    print_divider
    print "| ".blue
    print header.ljust(153).red
    puts " |".blue
    print_divider
  end

  def self.print_divider
    puts ("-" * 157).blue
  end

  def self.print_card_line(label, values, total_front_9 = '', total_back_9 = '', total = '')
    print "| ".blue
    print "%s" % label.ljust(6)
    print " |".blue
    values[0...9].each do |v|
      print "  %2s  " % v
      print "|".blue
    end
    print "  %2s  " % total_front_9
    print "|".blue
    values[9...18].each do |v|
      print "  %2s  " % v
      print "|".blue
    end
    print "  %2s  " % total_back_9
    print "|".blue
    print "  %2s  " % total
    puts "|".blue
    print_divider
  end
end
