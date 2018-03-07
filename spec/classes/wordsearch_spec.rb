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
end