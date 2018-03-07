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

  describe "search(word)" do
    it "should return an empty array if the word is not found in the puzzle" do
      expect(@wordsearch.search("TESTWORD")).to eq []
    end

    it 'should return an array of coordinates if the word is found in the puzzle on the x-axis' do
      # Case 1, only one match
      expected_coords = [
        [0,5],[1,5],[2,5],[3,5],[4,5],[5,5]
      ]
      expect(@wordsearch.search('SCOTTY')).to eq expected_coords
    end

    it 'should return an array of coordinates if the word is found in the puzzle in reverse on the x-axis' do
      # Case 1, only one match
      expected_coords = [
        [4,7],[3,7],[2,7],[1,7]
      ]
      expect(@wordsearch.search('KIRK')).to eq expected_coords
    end

    it 'should return an array of coordinates if the word is found in the puzzle on the y-axis' do
      # Case 1, only one match
      expected_coords = [
        [0,6],[0,7],[0,8],[0,9],[0,10]
      ]

      expect(@wordsearch.search("BONES")).to eq expected_coords
    end

    it 'should return an array of coordinates if the word is found in the puzzle in reverse on the y-axis' do
      # Case 1, only one match
      expected_coords = [
        [5,9],[5,8],[5,7],[5,6]
      ]

      expect(@wordsearch.search("KHAN")).to eq expected_coords
    end

    it 'should return an array of coordinates if the word is found on a diagonal over descending over the x-axis' do
      expected_coords = [
        [4,0],[3,1],[2,2],[1,3],[0,4]
      ]
      expect(@wordsearch.search('UHURA')).to eq expected_coords
    end

    it 'should return an array of coordinates if the word is found on a diagonal over descending in reverse over the x-axis' do
      expected_coords = [
        [3,3],[2,2],[1,1],[0,0]
      ]
      expect(@wordsearch.search('SULU')).to eq expected_coords
    end

    it 'should return an array of coordinates if the word is found on a diagonal over ascending over the x-axis' do
      expected_coords = [
        [2,1],[3,2],[4,3],[5,4],[6,5]
      ]
      expect(@wordsearch.search('SPOCK')).to eq expected_coords
    end

    it 'should return an array of coordinates if the word is found on a diagonal in reverse over ascending over the x-axis' do
      expected_coords = [
        [12,12],[11,11],[10,10]
      ]
      expect(@wordsearch.search('ZOE')).to eq expected_coords
    end
  end

  describe 'complete' do
    it "should print out the solution to the word search" do
      wordsearch = Wordsearch.new File.open('spec/support/test2.txt')
      expect(wordsearch.complete).to eq <<~EOS
        FUN: (12,3),(13,3),(14,3)
        HELLO: (14,0),(13,1),(12,2),(11,3),(10,4)
        PROGRAMMING: (0,0),(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10)
        RAILS: (4,9),(3,8),(2,7),(1,6),(0,5)
        RSPEC: (9,8),(9,7),(9,6),(9,5),(9,4)
        RUBY: (4,9),(5,8),(6,7),(7,6)
        TDD: (1,5),(2,6),(3,7)
        TESTING: (1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14)
        WORLD: (8,3),(7,3),(6,3),(5,3),(4,3)
      EOS
    end
  end
end