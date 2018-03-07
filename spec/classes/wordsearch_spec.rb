require 'spec_helper'

describe Wordsearch do
  before(:each) do
    @file = File.open('spec/support/test.txt')
    @wordsearch = Wordsearch.new(@file)
  end

  describe "initialize" do
    it "should be take a file and make it attr_readable" do
      expect(@wordsearch.file).to eq(@file)
    end

    it "should take the comma separated words from the first line of the file and set them to an attr_readable array" do
      expect(@wordsearch.search_words).to eq(File.foreach(@file).first.strip.split(','))
    end

    it "should store the puzzle as a hash with each letter storing an array of coordinates where that letter appears" do
      # rewind and remove the first line so we can test the puzzle portion
      @file.rewind && @file.readline

      @file.each_line.with_index do |line, y|
        line.strip.split(',').each_with_index do |letter, x|
          expect(@wordsearch.puzzle[letter].include? [x,y]).to be true
        end
      end
    end
  end

  describe "search_horizontally(word)" do
    it "should return an empty list if the word is not found in the puzzle" do
      expect(@wordsearch.search_horizontally("TESTWORD")).to eq []
    end

    it 'should return an array of coordinates if the word is found in the puzzle on the x-axis' do
      # Case 1, only one match
      expected_coords = [
          [[0,5],[1,5],[2,5],[3,5],[4,5],[5,5]]
      ]
      expect(@wordsearch.search_horizontally('SCOTTY')).to eq expected_coords

      # Case 2, two matches horizontally
      expected_coords = [
          [[10, 5], [11, 5]],
          [[13, 7], [14, 7]]
      ]
      expect(@wordsearch.search_horizontally('PP')).to eq expected_coords
    end
  end

  describe 'search_vertically(word)' do
    it 'should return an empty array if the word is not found on the y-axis' do
      expect(@wordsearch.search_vertically('abcd123')).to eq []
    end

    it 'should return an array of coordinates if the word is found in the puzzle on the y-axis' do
      # Case 1, only one match
      expected_coords = [
          [[0,6],[0,7],[0,8],[0,9],[0,10]]
      ]

      expect(@wordsearch.search_vertically("BONES")).to eq expected_coords

      # Case 2, more than one match
      expected_coords = [
          [[0,4],[0,5]],
          [[0,13],[0,14]],
          [[4,13],[4,14]]
      ]

      expect(@wordsearch.search_vertically("AS")).to eq expected_coords
    end
  end
end