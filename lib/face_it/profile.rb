
class FaceIt::Profile

  attr_accessor :name, :smile, :gender, :age, :moustache, :beard,
                :sideburns, :glasses, :emoji, :favorite_animal,
                :favorite_food, :quote ,:url

  @@all = []

  ANIMALS = ["dog","wolf","mouse","cat","hamster","rabbit","frog","koala","bear","pig","cow","dragon","monkey","horse",
    "sheep","elephant","panda_face","penguin","bird","chicken","snake","turtle","bee","dolphin","whale", "fish","leopard"]

  FOODS = ["pizza","hamburger","fries","spaghetti","fried_shrimp","sushi","poultry_leg","meat_on_bone","rice_ball","rice_cracker",
    "rice","ramen","stew","bread","doughnut","icecream","cake","cookie","chocolate_bar"]

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
    if smile.between?(0.3,0.5)
      self.emoji = "information_desk_person"
    elsif glasses == "Sunglasses"
      self.emoji = glasses.downcase
    elsif smile.between?(0.5,1.0)
      self.emoji = "smile"
    else
      self.emoji = "dancer"
    end
  end

  def set_quote(quote)
    quote = "\"#{quote.capitalize}\""
    self.quote = quote
  end

  def self.all
    @@all
  end

  def self.include_animal?(input)
    ANIMALS.include?(input)
  end

  def self.include_food?(input)
    FOODS.include?(input)
  end

  def self.all_animals
    ANIMALS
  end

  def self.all_foods
    FOODS
  end

  def self.set_favorite_animal(input)
    selected_profile.favorite_animal = input
  end

  def self.set_favorite_food(input)
    selected_profile.favorite_food = input
  end

  def self.find_and_select(input)
    @selected_profile = all.detect{|profile| profile.name.downcase == input.downcase}
  end

  def self.selected_profile
    @selected_profile
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

  def self.delete_profile(profile)
    all.delete(profile)
  end

end
