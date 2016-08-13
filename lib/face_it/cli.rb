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
    FaceIt::Table.profile_options
    profile_options(profile)

  end

  def profile_options(profile)
    input = gets.strip
    input.downcase!

    case input
      when "edit"
        edit_profile(profile)
      when "delete"
        delete_profile(profile)
      when "back"
        list_profiles
        find_profile
      else
        puts"Wrong input. Try again..."
        profile_options(profile)
    end
  end

  def edit_profile(profile)
    FaceIt::Table.edit_options
    input = gets.strip
    input.downcase!

    case input
      when "add favorite animal"
        add_favorite_animal
      when "add favorite food"
        add_favorite_food
      when "add quote"
        add_quote
      when "back"
        display_profile(profile)
    end
  end

  def delete_profile(profile)
    FaceIt::Profile.delete_profile(profile)
    list_profiles
    find_profile
  end

  def add_favorite_animal

  end

  def add_favorite_food

  end

  def add_quote

  end

  # 03-Parmanand Sahadeo-https://c1.staticflickr.com/9/8698/28614707280_4033c245d7_b.jpg
  # 04-Dmitriy Khait-https://c1.staticflickr.com/9/8630/28824327311_de1afb9672_b.jpg
  # 05-Paige Ellis-https://c1.staticflickr.com/9/8744/28300683813_143e24bb43_o.png
  # 06-Sol Jin-https://c1.staticflickr.com/9/8585/28299012194_54ed2e4742_b.jpg


end
