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

  def search(word)
    locations = []
    starting_coords = @puzzle[word[0]] || []
    starting_coords.each do |starting_coord|
      [
        [1, 0],     # Horizontal Forward
        [-1, 0],    # Horizontal Reverse
        [0, 1],     # Vertical Forward
        [0, -1],    # Vertical Reverse
        [1, 1],     # Diagonal Asc Forward
        [1, -1],    # Diagonal Asc Reverse
        [-1, -1],   # Diagonal Desc Forward
        [-1, 1],    # Diagonal Desc Reverse
      ].each do |next_coord_modifier|
        # remove the first letter since we have the coords for the first letter
        letters = word.split('')
        letters.shift

        coord_list = get_coord_list(
          coord: starting_coord,
          modifier: next_coord_modifier,
          letters: letters,
          coords: [starting_coord]
        )

        locations << coord_list unless coord_list.length < word.length
      end
    end

    locations
  end

  def get_coord_list(**args)
    x,y = args[:coord]
    coords = args[:coords] || []
    x_modifier, y_modifier = args[:modifier]
    letters = args[:letters]
    next_coord = (@puzzle[letters.shift] || []).select { |coord| coord == [x+x_modifier, y+y_modifier] }.first
    coords << next_coord

    if letters.empty? || next_coord.nil?
      coords.compact
    else
      get_coord_list(coord: next_coord, letters: letters, coords: coords, modifier: args[:modifier])
    end
  end
end