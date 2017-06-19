class User
  attr_accessor :name, :wins, :losses
  @@all = []

  def initialize
    @name = nil
    @wins = 0
    @losses = 0
  end

  def save
    #save game info for all new users or update an existing user's info
    if !@@all.include?(self)
      @@all << self
    else
      self.update
    end
  end

  def update
    #update an existing object in the @@all array
    if !@@all.index(self).nil?
      @@all[@@all.index(self)] = self
    end
  end

  def add_win
    @wins += 1
  end

  def add_loss
    @losses += 1
  end

  def self.all
    @@all
  end

  def self.find_by_name(user_name)
    self.all.each do |user|
      if user.name == user_name
        return user.name
      end
    end
  end

end
