#CLI Controller
require 'pry'
require 'gemoji'
require 'colorize'
require 'paint'

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

    case input
      when "exit"
        exit
      when "list profiles"
        list_profiles
        find_profile
      when "create profile"
        puts" -------------------------------------------------------------------------------".colorize(:red)
        puts"|-----------------------------> RESTRICTED ACCESS <-----------------------------|".colorize(:red)
        puts"|----------------------------->    COMING SOON    <-----------------------------".colorize(:red)
        puts" -------------------------------------------------------------------------------".colorize(:red)
        welcome_follow_up
      else
        puts"Wrong input. Try again...".colorize(:cyan)
        welcome_follow_up
    end
  end

  def list_profiles
    FaceIt::Table.profiles_prompt_display(FaceIt::Profile.all)
  end

  def find_profile
    input = gets.strip
    input.downcase!
    if input != "back"
      if FaceIt::Profile.includes_name(input)
        FaceIt::Profile.find_and_select(input)
        display_profile
      else
        puts"Wrong input. Try again...".colorize(:cyan)
        list_profiles
        find_profile
      end
    else
      welcome_follow_up
    end
  end

  def display_profile
    puts ""
    FaceIt::Table.profiles_display(FaceIt::Profile.selected_profile)
    FaceIt::Table.profile_options
    profile_options
  end

  def profile_options
    input = gets.strip
    input.downcase!

    case input
      when "edit"
        FaceIt::Table.edit_options
        edit_profile
      when "delete"
        puts"\n \n"
        puts"ARE YOU SURE?!?!?!".colorize(:red)+" (If this profile is deleted, you will not be able to get it back)".colorize(:cyan)
        delete_profile
      when "back"
        list_profiles
        find_profile
      else
        puts"Wrong input. Try again...".colorize(:cyan)
        profile_options
    end
  end

  def edit_profile
    input = gets.strip
    input.downcase!

    case input
      when "add favorite animal"
        puts "\n\nWHAT IS YOUR FAVORITE ANIMAL? (type \"list animals\" to list all the animals available)".colorize(:cyan)
        add_favorite_animal
      when "add favorite food"
        puts "\n\nWHAT IS YOUR FAVORITE FOOD? (type \"list foods\" to list all the foods available)".colorize(:cyan)
        add_favorite_food
      when "add quote"
        add_quote
      when "back"
        display_profile
      else
        puts"Wrong input. Try again...".colorize(:cyan)
        edit_profile
    end
  end

  def delete_profile
    input = gets.strip
    input.downcase!

    case input
    when "yes" , "y"
      FaceIt::Profile.delete_profile(FaceIt::Profile.selected_profile)
      list_profiles
      find_profile
    when "no" , "n"
      display_profile
    else
      puts"Wrong input. Try again...".colorize(:cyan)
      delete_profile
    end
  end

  def add_favorite_animal
    input = gets.strip
    input.downcase!
    if input == "list animals"
      list_animals
      puts "\n\nTYPE AN ANIMAL NAME:".colorize(:cyan)
      add_favorite_animal
    elsif FaceIt::Profile.include_animal?(input)
      FaceIt::Profile.set_favorite_animal(input)
      display_profile
    else
      puts"Animal not recognized, pick another one or type \"list animals\" to see our collection".colorize(:cyan)
      add_favorite_animal
    end
  end

  def add_favorite_food
    input = gets.strip
    input.downcase!

    if input == "list foods"
      list_foods
      puts "\n\nTYPE A FOOD NAME:".colorize(:cyan)
      add_favorite_food
    elsif FaceIt::Profile.include_food?(input)
      FaceIt::Profile.set_favorite_food(input)
      display_profile
    else
      puts"Food not recognized, pick another one or type \"list foods\" to see our collection".colorize(:cyan)
      add_favorite_food
    end
  end

  def add_quote
    puts "\n\nWHAT WILL YOUR QUOTE SAY?".colorize(:cyan)
    input = gets.strip
    FaceIt::Profile.selected_profile.set_quote(input)
    display_profile
  end

  def list_animals
    puts"\n\n"
    FaceIt::Profile.all_animals.each {|animal| puts animal.colorize(:cyan)}
  end

  def animal_available?(input)
    FaceIt::Profile.all_animals.include?(input)
  end

  def list_foods
    puts"\n\n"
    FaceIt::Profile.all_foods.each {|food| puts food.colorize(:cyan)}
  end

  def food_available?(input)
    FaceIt::Profile.all_foods.include?(input)
  end


end
