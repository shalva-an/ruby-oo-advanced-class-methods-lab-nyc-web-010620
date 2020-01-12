class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    song = self.new   # initializes a song (song = Song.new)
    self.all << song  # save initialization of song to @@all (Song.all)
    # can also be song.save as it's equal to: self.all << self
    song              # return the song instance that we just created
  end

  def self.new_by_name(title)
    song = self.new   # initializes a song (song = Song.new)
    song.name = title # :name constructor will equal to title
    song  # return the song
  end

  def self.create_by_name(title)
    song = self.create
    song.name = title 
    song
  end

  def self.find_by_name(title)
    self.all.find{|song| song.name == title}
    # find the first match of where the string being passed(title)
    # matches the song in our database (self.all)
    # searching through self.all.name to match title
    # return false if not found
  end

  def self.find_or_create_by_name(title)
    # Run ONLY find_by_name method if the condition is true
    # Run ONLY create_by_name if and only if find_by_name returns false
    # Does not, and should not work the other way
    self.find_by_name(title) || self.create_by_name(title)
  end

  def self.alphabetical
    self.all.sort_by {|title| title.name}
  end

  def self.new_from_filename(artist_and_title)
    # Split the string into arrays where the condition
    # of " - " meets. An arrary with a size of 2 should be created
    
    fields = artist_and_title.split(" - ")
    artist_name = fields[0] # First array
    song_name = fields[1] # Second Array

    song = self.new

    # str.chomp(".mp3") => will remove .mp3 from end of the str string
    # str.gsub(".mp3", "") => will replace all occurances of .mp3 with blank
    # Don't know which one is more efficient
    
    song.name = song_name.chomp(".mp3")
    song.artist_name = artist_name
    song  # return the song instance we just created
  end

  def self.create_from_filename(artist_and_title)
    fields = artist_and_title.split(" - ")
    artist_name = fields[0]
    song_name = fields[1]

    song = self.create # actually create and shovel into @@all
    song.name = song_name.chomp(".mp3")
    song.artist_name = artist_name
    song
  end

  def self.destroy_all
    # Array#clear method to empty the @@all array through the
    # class reader Song.all
    self.all.clear
  end


end

# p song1 = Song.new_by_name("ShalvaNewByName")
# p song2 = Song.create_by_name("CreatedByName")
# p song3 = Song.new_by_name("AnotherOneNewByName")
# p song4 = Song.create_by_name("CreatedByDust")
# p Song.all

# s1 = Song.new_from_filename("Taylor Swift - Blank Space.mp3")
#p s1.name
#p s1.artist_name
# song.artist_name #=> "Taylor Swift"