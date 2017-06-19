class Game
  attr_accessor :users_name, :user_input, :chosen_word, :game_status, :word_in_progress, :wrong_answers, :has_won, :has_lost, :user, :wants_to_play, :guessed_array

  VALID_LETTERS = ('a'..'z').to_a

  def initialize
    @wrong_answers = 0
    @has_won = false
    @has_lost = false
    @wants_to_play = true
    @user = User.new
    @guessed_array = []
  end

  def welcome
    #prints welcome message and gets a user's name
    puts "Welcome to Hangman! Please enter your name:"
    self.user_name
  end

  def user_name
    #gets and saves user's name
    @users_name = gets.chomp
    # binding.pry
    var = @user.class.all.select do |user|
      user.name == @users_name
    end
    if var != []
      puts "Welcome back, #{@users_name}."
    end
    @user.name = @users_name
  end

  def generate_word
    word_list = ["apple", "banana", "grape", "orange", "supercalifragilisticexpialidocious", "stick", "trick", "schtick", "wicked", "sick", "dog", "cat", "fruit"]
    random_index = Random.new
    @chosen_word = word_list[random_index.rand(word_list.length)]
    @word_in_progress = nil
    @has_won = false
    @has_lost = false
    @wrong_answers = 0
    @guessed_array = []
    #binding.pry
  end

  def user_input
    #gets and saves user input
    #checks to see that the input was only one letter -> if array.length != 1 put out error message
    puts "Enter a letter: "
    @user_input = gets.chomp.downcase.chr
    if VALID_LETTERS.index(@user_input).nil?
      puts "Invalid character"
      #binding.pry
      user_input
    end
    if @guessed_array.index(@user_input)
      puts "Letter already guessed"
      user_input
    end
    @guessed_array << @user_input
    @user_input
  end

  def game_status
    if @word_in_progress.nil?
      return true
    end
    if @word_in_progress.split('').index('_').nil?
      @has_won = true
      return false
    else
      true
    end
    if @wrong_answers == 6
      @has_lost = true
      return false
    else
      true
    end
  end

  def merge_answers(ans1, ans2)
    ans_to_return = []
    ans1.split('').each_with_index do |item, index|
      if ans2.split('')[index] != '_' && ans1.split('')[index] == '_'
        item = ans2.split('')[index]
        # binding.pry
      end
      ans_to_return << item
    end
    ans_to_return.join
  end

  def generic_letter_check(word)
    var = word.split('').map do |char|
      if char == @user_input
        char
      else
        "_"
      end
    end.join
    # binding.pry
    var
  end

  def check_letter
    if @word_in_progress.nil?
      @word_in_progress = generic_letter_check(@chosen_word)
      if @word_in_progress.delete('_').empty?
        @wrong_answers += 1
      end
    else
      if merge_answers(@word_in_progress, generic_letter_check(@chosen_word)).delete('_').empty?
        @wrong_answers += 1
      elsif @word_in_progress == merge_answers(@word_in_progress, generic_letter_check(@chosen_word))
        @wrong_answers += 1
      else
        @word_in_progress = merge_answers(@word_in_progress, generic_letter_check(@chosen_word))
      end
    end
    puts @word_in_progress
  end

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

  def determine_w_or_l
    if @has_won
      @user.add_win
      @user.save
    elsif @has_lost
      @user.add_loss
      @user.save
    end
  end

  def save
    #calls on save method from User class to save a user's game
    puts "Would you like to play again? Y/N"
    @user_input = gets.chomp.downcase
    if @user_input == "y" || @user_input == "yes"
      self.determine_w_or_l
    elsif @user_input == "n" || @user_input == "no"
      self.determine_w_or_l
      @wants_to_play = false
    else
      puts "Invalid input. Please try again."
      self.save
    end
  end
end
