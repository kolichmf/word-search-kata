class Wordsearch
  attr_reader :file, :search_words, :puzzle

  def initialize(file)
    @file = file
    @search_words = @file.readline.strip.split(',')
    @puzzle = {}
    @file.each_line.with_index do |line, y|
      line.strip.split(',').each_with_index do |letter, x|
        @puzzle[letter] ||= []
        @puzzle[letter] << [x,y]
      end
    end
  end
end