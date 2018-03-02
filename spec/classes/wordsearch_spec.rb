require 'spec_helper'

describe Wordsearch do
  it "should be take a file and make it attr_readable" do
    file = File.open('spec/support/test.txt')
    wordsearch = Wordsearch.new(file)
    expect(wordsearch.file).to eq(file)
    file.close
  end
end