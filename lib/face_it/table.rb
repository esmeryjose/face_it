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
        :width => 145, :color => 'cyan', align: 'center', :bold => true
      end
    end
  end

  def self.welcome_follow_up_display
    table :border => true do
      row :color => 'light_blue' do
        column "LIST PROFILES", :width => 70, :color => 'cyan', align: 'center'
        column "EXIT", :width => 70, :color => 'red', align: 'center'
      end
    end
    puts"\n \n"
  end

  def self.profiles_prompt_display(profiles)
    table :border => false do
      row :color => 'light_blue' do
        column "WHICH PROFILE DO YOU WANT TO SEE?", :width => 190, :color => 'cyan', align: 'center'
      end
    end
    table :border => true do
      row :color => 'light_blue' do
        profiles.each do |profile|
          column profile.name, :width => 25, :color => 'cyan', :align => 'center'
        end
        column "back", :width => 25, :color => 'red', :align => 'center'
      end
    end
    puts"\n \n"
  end

  def self.profiles_display(profile)
    puts"\n \n \n"
    table :border => false do
      row :color => 'light_blue' do
        column "#{Emoji.find_by_alias(profile.emoji).raw}   #{profile.name.upcase} #{Emoji.find_by_alias(profile.emoji).raw}", :width => 80, :color => 'green', align: 'center'
      end
    end
    table :border => true do
       # binding.pry
      table_smile(profile) if profile.user_smile

      table_moustache(profile) if profile.user_moustache

      table_beard(profile) if profile.user_beard

      table_sideburns(profile) if profile.user_sideburns

      table_glasses(profile) if profile.user_glasses

      row :color => 'light_blue' do
        column "#{profile.name} is a #{profile.gender}", :width => 80, :color => 'green', align: 'left'
      end
      row :color => 'light_blue' do
        column "FaceIt thinks #{profile.name} is #{profile.age}!", :width => 80, :color => 'green', align: 'left'
      end
    end
    puts"\n \n \n"
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


end
