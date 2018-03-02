class Wordsearch
  attr_reader :file, :search_words
  def initialize(file)
    @file = file
    @search_words = @file.readline.split(',')
  end
end