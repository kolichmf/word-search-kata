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

  def search_horizontally(word)
    letters = word.split('')
    @puzzle[letters.shift].map { |starting_coord|
      coord_list = [starting_coord]
      x,y = starting_coord
      letters.each_with_index do |letter, index|
        coord_list << @puzzle[letter].select {|coord| coord == [x+index+1, y]}.first
      end
      coord_list
    }
    .reject { |coord_list| coord_list.any?(&:nil?) }
  end
end