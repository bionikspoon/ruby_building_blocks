def caesar_cipher text, shift
  letters =('a'..'z').to_a
  letters_cycle = letters.cycle(2).to_a

  text.each_char.collect do |char|
    unless letters.include? char.downcase
      next char
    end

    encoded = letters_cycle[letters.index(char.downcase) + shift]

    char == char.downcase ? encoded : encoded.upcase

  end.join
end