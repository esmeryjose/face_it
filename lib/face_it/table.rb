require 'command_line_reporter'
require 'gemoji'
require 'pry'
require 'colorize'


class FaceIt::Table
  extend CommandLineReporter

  def self.welcome_display
    table :border => false do
      row :color => 'blue' do
        column "#{Emoji.find_by_alias("laughing").raw} #{Emoji.find_by_alias("stuck_out_tongue_closed_eyes").raw}  WELCOME TO FACEIT #{Emoji.find_by_alias("grin").raw} #{Emoji.find_by_alias("joy").raw}",
        :width => 155, :color => 'cyan', align: 'center', :bold => true
      end
    end
  end

  def self.welcome_follow_up_display
    puts"\n \n"
    table :border => true do
      row :color => 'light_blue' do
        column "LIST PROFILES", :width => 50, :color => 'cyan', align: 'center'
        column "CREATE PROFILE (work in progress...)", :width => 50, :color => 'cyan', align: 'center'
        column "EXIT", :width => 50, :color => 'white', align: 'center'
      end
    end
    puts"\n \n"
  end

  def self.profiles_prompt_display(profiles)
    puts"\n \n"
    table :border => false do
      row :color => 'light_blue' do
        column "  WHICH PROFILE DO YOU WANT TO SEE?", :width => 190, :color => 'cyan', align: 'left'
      end
    end
    table :border => true do
      row :color => 'light_blue' do
        profiles.each do |profile|
          column profile.name, :width => 25, :color => 'cyan', :align => 'center'
        end
        column "back", :width => 25, :color => 'white', :align => 'center'
      end
    end
    puts"\n \n"
  end

  def self.profiles_display(profile)
    # binding.pry
    puts"\n \n \n"
    table :border => false do
      row :color => 'light_blue' do
        column "#{Emoji.find_by_alias(profile.emoji).raw}   #{profile.name.upcase} #{Emoji.find_by_alias(profile.emoji).raw}", :width => 80, :color => 'green', align: 'center'
      end
      table_profile_quote(profile) if profile.quote
    end
    table :border => true do
       # binding.pry
      table_smile(profile) if profile.user_smile

      table_moustache(profile) if profile.user_moustache

      table_beard(profile) if profile.user_beard

      table_sideburns(profile) if profile.user_sideburns

      table_glasses(profile) if profile.user_glasses

      table_favorite_animal(profile) if profile.favorite_animal

      table_favorite_food(profile) if profile.favorite_food

      row :color => 'light_blue' do
        column "#{profile.name} is a #{profile.gender}", :width => 80, :color => 'green', align: 'left'
      end
      row :color => 'light_blue' do
        column "FaceIt thinks #{profile.name} is #{profile.age}!", :width => 80, :color => 'green', align: 'left'
      end
    end
  end

  def self.profile_options
    table :border => true do
      row :color => 'light_blue' do
        column "EDIT", :width => 40, :color => 'green', align: 'center'
        column "DELETE", :width => 40, :color => 'red', align: 'center'
        column "BACK", :width => 40, :color => 'white', align: 'center'
      end
    end
    puts"\n \n"
  end

  def self.edit_options
    puts"\n \n"
    table :border => false do
      row :color => 'light_blue' do
        column "  WHAT WOULD YOU LIKE TO EDIT?", :width => 170, :color => 'cyan', align: 'left'
      end
    end
    table :border => true do
      row :color => 'light_blue' do
        column "ADD FAVORITE ANIMAL", :width => 40, :color => 'cyan', align: 'center'
        column "ADD FAVORITE FOOD", :width => 40, :color => 'cyan', align: 'center'
        column "ADD QUOTE", :width => 40, :color => 'cyan', align: 'center'
        column "BACK", :width => 40, :color => 'white', align: 'center'
      end
    end
    puts"\n \n"
  end

  def self.table_smile(profile)
    # binding.pry
    row :color => 'light_blue' do
      column profile.user_smile, :width => 80, :color => 'green', align: 'left'
    end
  end

  def self.table_moustache(profile)
    # binding.pry
    row :color => 'light_blue' do
      column profile.user_moustache, :width => 80, :color => 'green', align: 'left'
    end
  end

  def self.table_beard(profile)
    # binding.pry
    row :color => 'light_blue' do
      # binding.pry
      column profile.user_beard, :width => 80, :color => 'green', align: 'left'
    end
  end

  def self.table_sideburns(profile)
    # binding.pry
    row :color => 'light_blue' do
      # binding.pry
      column profile.user_sideburns, :width => 80, :color => 'green', align: 'left'
    end
  end

  def self.table_glasses(profile)
    # binding.pry
    row :color => 'light_blue' do
      column profile.user_glasses, :width => 80, :color => 'green', align: 'left'
    end
  end

  def self.table_profile_quote(profile)
    row :color => 'light_blue' do
      column "#{profile.quote}", :width => 80, :color => 'green', align: 'center'
    end
  end

  def self.table_favorite_animal(profile)
    # binding.pry
    row :color => 'light_blue' do
      column "#{profile.name}'s favorite animal is #{profile.favorite_animal.gsub("_"," ")}  #{Emoji.find_by_alias(profile.favorite_animal).raw}", :width => 80, :color => 'green', align: 'left'
    end
  end

  def self.table_favorite_food(profile)
    # binding.pry
    row :color => 'light_blue' do
      column "#{profile.name}'s favorite food is #{profile.favorite_food.gsub("_"," ")} #{Emoji.find_by_alias(profile.favorite_food).raw}", :width => 80, :color => 'green', align: 'left'
    end
  end
end
