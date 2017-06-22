class Game
  attr_accessor :users_name, :user_input, :chosen_word, :game_status, :word_in_progress, :wrong_answers, :has_won, :has_lost, :user, :wants_to_play, :guessed_array
  # NOTE these attributes reveal that would have multiple objects
    # For example, look to the preceding words
    # preceding words like user suggest they should be in the user object
    # wrong_answers, and guessed maybe are part of the same object as well, as is word in progress, and guessed array

  VALID_LETTERS = ('a'..'z').to_a

  def initialize
    @wrong_answers = 0
    @has_won = false
    @has_lost = false
    @wants_to_play = true
    @user = User.new
    @guessed_array = []
      # NOTE initializing array as instance variable is tip off that should be a new object
  end

  def welcome
    puts "Welcome to Hangman! Please enter your name:"
    self.user_name
  end

  def user_name
    #gets user's name and checks if it's a returning user
    @users_name = gets.chomp
    var = @user.class.all.select do |user|
      user.name == @users_name
    end
    if var != []
      puts "Welcome back, #{@users_name}."
    end
    @user.name = @users_name
  end
  # NOTE should be in the user class

  def generate_word
    #randomly selects a word for the game
    word_list = ["apple", "banana", "grape", "orange", "supercalifragilisticexpialidocious", "stick", "trick", "schtick", "wicked", "sick", "dog", "cat", "fruit"]
    random_index = Random.new
    @chosen_word = word_list[random_index.rand(word_list.length)]
    @word_in_progress = nil
    @has_won = false
    @has_lost = false
    @wrong_answers = 0
    @guessed_array = []
  end

  def user_input
    #gets and saves user input
    #checks if a user's input is a letter and not a letter already guessed
    puts "Enter a letter: "
    @user_input = gets.chomp.downcase.chr
    if VALID_LETTERS.index(@user_input).nil?
      puts "Invalid character"
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
    #checks if the game is still in progress
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
    #combines multiple guesses and outputs one string of the word being guessed
    ans_to_return = []
    # NOTE sandwich code
    ans1.split('').each_with_index do |item, index|
      if ans2.split('')[index] != '_' && ans1.split('')[index] == '_'
        item = ans2.split('')[index]
      end
      ans_to_return << item
    end
    ans_to_return.join
    # NOTE Would break this into steps and then code
  end

  def generic_letter_check(word)
    #checks if the guessed letter matches a letter in the word
    var = word.split('').map do |char|
      if char == @user_input
        char
      else
        "_"
      end
    end.join
    var
  end

  def check_letter
    #checks if the guessed letter matches a letter in the word and replaces
    #any blanks with the appropriate letter

    # NOTE nested if statements, the "and" in your comment suggests the method is doing too much.
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


  def determine_w_or_l
    #determines if the game has been won or lost
    #saves the result of the game and adds it to the user's total
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
      # NOTE looks like repetition
    elsif @user_input == "n" || @user_input == "no"
      self.determine_w_or_l
      @wants_to_play = false
    else
      puts "Invalid input. Please try again."
      self.save
      # this calls the same method?
    end
  end
end
