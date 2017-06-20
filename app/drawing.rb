class Drawing
  attr_accessor :wrong_answers
  
  def hangman_drawing
    #shows appropriate hangman illustration based on the number of incorrect
    #guesses by the user
    #This program uses the hangman ASCII illustration found on
    #www.berkeleyinternet.com/perl/node30.html
    case @wrong_answers
      when 0
          puts "0000000000000"
          puts "0           0"
          puts "0"
          puts "0"
          puts "0"
          puts "0"
          puts "0"
          puts "0"
          puts "0"
          puts "0"
          puts "0"
          puts "0"
          puts "0"
          puts "0"
          puts "0"

      when 1
        puts "0000000000000"
        puts "0           0"
        puts "0           1"
        puts "0          1 1"
        puts "0           1"
        puts "0"
        puts "0"
        puts "0"
        puts "0"
        puts "0"
        puts "0"
        puts "0"
        puts "0"
        puts "0"
        puts "0"

    when 2
        puts "0000000000000"
        puts "0           0"
        puts "0           1"
        puts "0          1 1"
        puts "0           1"
        puts "0           2"
        puts "0           2"
        puts "0           2"
        puts "0"
        puts "0"
        puts "0"
        puts "0"
        puts "0"
        puts "0"
        puts "0"

    when 3
        puts "0000000000000"
        puts "0           0"
        puts "0           1"
        puts "0          1 1"
        puts "0           1"
        puts "0          32"
        puts "0         3 2"
        puts "0        3  2"
        puts "0"
        puts "0"
        puts "0"
        puts "0"
        puts "0"
        puts "0"
        puts "0"

    when 4
        puts "0000000000000"
        puts "0           0"
        puts "0           1"
        puts "0          1 1"
        puts "0           1"
        puts "0          324"
        puts "0         3 2 4"
        puts "0        3  2  4"
        puts "0"
        puts "0"
        puts "0"
        puts "0"
        puts "0"
        puts "0"
        puts "0"

    when 5
        puts "0000000000000"
        puts "0           0"
        puts "0           1"
        puts "0          1 1"
        puts "0           1"
        puts "0          324"
        puts "0         3 2 4"
        puts "0        3  2  4"
        puts "0          5"
        puts "0         5"
        puts "0        5"
        puts "0       5"
        puts "0"
        puts "0"
        puts "0"

    when 6
        puts "0000000000000"
        puts "0           0"
        puts "0           1"
        puts "0          1 1"
        puts "0           1"
        puts "0          324"
        puts "0         3 2 4"
        puts "0        3  2  4"
        puts "0          5 6"
        puts "0         5   6"
        puts "0        5     6"
        puts "0       5       6"
        puts "0"
        puts "0"
        puts "0"

      else
        puts "this is impossible"
      end
    end
  end
