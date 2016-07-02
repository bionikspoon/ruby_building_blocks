def substrings text, dictionary
  counter = Hash.new(0)
  text.downcase.split(' ').each do |subtext|
    dictionary.select { |word| subtext.include? word }.each { |word| counter[word] +=1 }
  end
  counter
end