def caesar_cipher text, shift
  letters =('a'..'z').to_a

  text.each_char.collect do |char|
    unless letters.include? char.downcase
      next char
    end

    shifted_index = (letters.index(char.downcase) + shift) % letters.length
    encoded = letters[shifted_index]

    downcase?(char) ? encoded : encoded.upcase

  end.join
end

def downcase? char
  char == char.downcase
end