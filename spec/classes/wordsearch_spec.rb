require 'spec_helper'

describe Wordsearch do
  before(:each) do
    @file = File.open('spec/support/test.txt')
    @wordsearch = Wordsearch.new(@file)
  end

  it "should be take a file and make it attr_readable" do
    expect(@wordsearch.file).to eq(@file)
  end

  it "should take the comma separated words from the first line of the file and set them to an attr_readable array" do
    expect(@wordsearch.search_words).to eq(File.foreach(@file).first.split(','))
  end
end