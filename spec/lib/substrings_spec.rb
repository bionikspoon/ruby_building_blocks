require 'rspec'
require 'substrings'

describe 'Substrings' do

  before do
    @dictionary = ["below", "down", "go", "going", "horn", "how", "howdy", "it", "i", "low", "own", "part", "partner", "sit"]
  end

  it "should count number of substrings" do
    substrings("below", @dictionary).should eq({ 'below' => 1, 'low' => 1 })
  end

  it "should ignore case" do
    substrings("Below", @dictionary).should eq({ 'below' => 1, 'low' => 1 })
  end

  it "should handle multiple words" do
    expected = {
        "down" => 1, "how" => 2, "howdy" => 1, "go" => 1, "going" => 1, "it" => 2, "i" => 3, "own" => 1, "part" => 1, "partner" => 1, "sit" => 1
    }
    substrings("Howdy partner, sit down! How's it going?", @dictionary).should eq expected
  end
end