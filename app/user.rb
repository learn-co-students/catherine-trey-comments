class User
  attr_accessor :name, :wins, :losses
  @@all = []

  def initialize
    @name = nil
    @wins = 0
    @losses = 0
  end

  def save
    #checks if the user already exists in the @@all array
    #if it's a new user, add the user to the @@all array
    #if a user exists, call on self.update
    if !self.class.all.include?(self)
      self.class.all << self
    else
      self.update
    end
  end

  def update
    #updates a user's info in the @@all array
    if !self.class.all.index(self).nil?
      self.class.all[self.class.all.index(self)] = self
    end
  end

  def add_win
    # NOTE this data could be derived from number of games a user has played.

    #increases count of wins for a user
    @wins += 1
  end

  def add_loss
    #increases count of losses for a user
    @losses += 1
  end

  def self.all
    @@all
  end

  def self.find_by_name(user_name)
    #finds a user's name in the @@all array
    # NOTE use select.
    self.all.each do |user|
      if user.name == user_name
        return user.name
      end
    end
  end

  def display_player_stat
    #displays the stats for a player
    puts "Player Name: #{name} Wins: #{wins} Losses: #{losses}"
  end
end
