require 'pry'

class FaceIt::FileExecute
  attr_accessor :files, :url
  attr_reader :path

  def initialize(path)
    @path = path
    @files = file_reader
    create_profiles
  end

  def file_reader
    File.readlines(path)
  end

  def create_profiles
    files.each do |file|
      create_indiv_profile(file)
    end
  end

  def create_indiv_profile(file)
    split = file.split("-")
    url = split[2]
    profile_hash = query_api(url).profile_hash
    profile_hash[:name] = split[1]
    FaceIt::Profile.new(profile_hash)
  end

  def query_api(url)
    FaceIt::API.new(url)
  end

end
