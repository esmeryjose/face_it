#CLI Controller
require 'pry'
require 'gemoji'
require 'colorize'

class FaceIt::CLI

  def call
    FaceIt::FileExecute.new('./links/urls')
    welcome_screen
  end

  def welcome_screen
    puts"\n \n \n"
    FaceIt::Table.welcome_display
    welcome_follow_up
  end

  def welcome_follow_up
    FaceIt::Table.welcome_follow_up_display
    input = gets.strip
    input.downcase!

    if input != "exit"
      if input == "list profiles"
        list_profiles
        find_profile
      else
        puts"Wrong input. Try again..."
        welcome_follow_up
      end
    end
  end

  def list_profiles
    FaceIt::Table.profiles_prompt_display(FaceIt::Profile.all)
  end

  def find_profile
    input = gets.strip
    input.downcase!
    if input != "back"
      # binding.pry
      if FaceIt::Profile.includes_name(input)
        # binding.pry
        display_profile(FaceIt::Profile.find_by_name(input))
      else
        puts"Wrong input. Try again..."
        list_profiles
        find_profile
      end
    else
      welcome_follow_up
    end
  end

  def display_profile(profile)
    puts ""
    FaceIt::Table.profiles_display(profile)
    welcome_follow_up
  end


end
