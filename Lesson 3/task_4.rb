vowels = {}

alphabet = ('a'..'z').to_a

a_vowels = ['a', 'e', 'i', 'o', 'u', 'y']

alphabet.each_with_index do |letter, index|
  vowels[letter] = index + 1 if a_vowels.include?(letter)
end
  
puts vowels
