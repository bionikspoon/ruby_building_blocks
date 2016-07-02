def substrings text, dictionary
  counter = Hash[dictionary.zip [0].cycle]
  text.downcase.split(' ').each do |subtext|
    dictionary.select { |word| subtext.include? word }.each { |word| counter[word] +=1 }
  end
  counter.select { |word, count| count > 0 }

end