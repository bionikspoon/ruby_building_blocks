require 'spec_helper'
require 'cipher'

describe 'Caesar Cipher' do
  it "should shift single letters 'a', 1 to 'b'" do
    caesar_cipher('a', 1).should eq 'b'
  end

  it "should shift single letters 'a', 2 to 'c'" do
    caesar_cipher('a', 2).should eq 'c'
  end

  it "should shift single letters 'z', 1 to 'a'" do
    caesar_cipher('z', 1).should eq 'a'
  end

  it "should shift multiple letters 'ab', 1 to 'bc'" do
    caesar_cipher('ab', 1).should eq 'bc'
  end

  it "should not shift non letters" do
    caesar_cipher(',', 1).should eq ','
  end

  it "should shift uppercase letters" do
    caesar_cipher('A', 1).should eq 'B'
  end

  it 'should shift entire words' do
    caesar_cipher("What", 5).should eq "Bmfy"
  end

  it "should shift spaces" do
    caesar_cipher(" ", 5).should eq " "
  end

  it "should shift each letter in a string" do
    caesar_cipher("What a string!", 5).should eq "Bmfy f xywnsl!"
  end

  it "should shift negative numbers 'b', -1 to 'a'" do
    caesar_cipher('b', -1).should eq 'a'
  end

  it "should shift negative numbers 'ab', -1 to 'za'" do
    caesar_cipher('b', -1).should eq 'a'
  end

  it "should shift negative numbers to decode words" do
    caesar_cipher('Bmfy', -5).should eq 'What'
  end

  it 'should decode phrases' do
    caesar_cipher("Bmfy f xywnsl!", -5).should eq "What a string!"
  end
end