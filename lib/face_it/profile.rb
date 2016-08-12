class FaceIt::Profile

  attr_accessor :name, :smile, :gender, :age, :moustache, :beard, :sideburns, :glasses, :emoji

  @@all = []
  def initialize(profile_hash)
    profile_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    @@all << self
    set_imoji
  end

  def user_smile
    if smile >= 0.3
      "#{name} is Smiling."
    end
  end

  def user_moustache
    if moustache >= 0.3
      "#{name} has a moustache."
    end
  end

  def user_beard
    # binding.pry
    if beard >= 0.3
      "#{name} has a beard."
    end
  end

  def user_sideburns
    # binding.pry
    if sideburns >= 0.3
      "#{name} has sideburns."
    end
  end

  def user_glasses
    if glasses == "Sunglasses"
      "#{name} is wearing Sunglasses."
    elsif glasses == "ReadingGlasses"
      "#{name} is wearing Reading glasses"
    end
  end

  def user_age
    "FaceIt thinks #{name} is #{age.to_i}!!!"
  end

  def set_imoji
    if gender == "male"
      set_imoji_male
    elsif gender == "female"
      set_imoji_female
    end
  end

  def set_imoji_male
    if sideburns.between?(0.3,1.0) && beard.between?(0.3,1.0)
      self.emoji = "guardsman"
    elsif moustache.between?(0.2,1.0)
      self.emoji = "man"
    elsif glasses == "Sunglasses"
      self.emoji = glasses.downcase
    elsif smile
      self.emoji = "smile"
    else
      self.emoji = "walking"
    end
  end

  def set_imoji_female
    if glasses == "sunglasses"
      self.emoji = glasses.downcase
    elsif smile.between?(0.3,0.5)
      self.emoji = "information_desk_person"
    elsif smile.between?(0.5,1.0)
      self.emoji = "smile"
    else
      self.emoji = "dancer"
    end
  end

  def self.all
    @@all
  end

  def self.find_by_name(input)
    all.detect{|profile| profile.name.downcase == input.downcase}
  end

  def self.includes_name(input)
    result = false
    all.each do |profile|
      if profile.name.downcase == input.downcase
        result = true
      end
    end
    result
  end


end
