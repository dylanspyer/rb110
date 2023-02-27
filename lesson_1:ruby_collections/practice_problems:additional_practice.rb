# Practice Problem 1

# flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
# # 3 ways to solve it:

# # hash = {}
# # flintstones.each_with_index do |name, index|
# #   hash[name] = index
# # end
# # p hash

# # index = 0
# # p (flintstones.each_with_object({}) do |name, hash|
# #   hash[name] = index
# #   index += 1
# # end)

# # hash = {}
# # counter = 0
# # loop do
# #   current_name = flintstones[counter]
# #   hash[current_name] = counter
# #   counter += 1
# #   break if counter > 5
# # end

# # Practice Problem 2

# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

# # p ages.values.sum

# # p ages.values.reduce(:+)
# # p ages.values.reduce { |sum, age| sum + age}

# # names = ages.keys
# # index = 0
# # sum = 0
# # loop do
# #   current_person_age = ages[names[index]]
# #   sum += current_person_age
# #   index += 1
# #   break if index > 5
# # end
# # p sum

# # Practice Problem 3

# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# ages.delete_if { |_, age| age >= 100}

# ages.keep_if {|_, age| age < 100 }

# ages.select! {|_, age| age < 100}

# names = ages.keys
# counter = 0
# loop do
#   current_age = ages[names[counter]]
#   current_name = names[counter]
#   if current_age >= 100
#     ages.delete(current_name)
#     counter += 1
#   else
#     counter += 1
#     break if counter >= 4
#   end
# end
# p ages

# # Practice Problem 4

# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

# # p ages.values.min

# # Practice Problem 5

# flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# # flintstones.each_with_object('') do |name, be_name|
# #   name.each_char.with_index do |letter, index|
# #     next if name[index+1] == nil
# #     if name[index] + name[index+1] == 'Be'
# #       be_name << name
# #     end 
# #   end
# # end

# Iterate through the array
#   - Iterate through the first two letters of the word
#   - If those letters are 'Be',
#   - Break out of the inner loop
# - Break out of the outer loop

# p flintstones.index { |name| name[0, 2] == 'Be'}

# # Practice Problem 6

# flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
# flintstones.map! { |name| name = name[0..2] }

# # Practice Problem 7

# statement = "The Flintstones Rock"

# p statement.each_char.with_object(Hash.new(0)) { |char, hash| next if char == ' '; hash[char] += 1}

# p statement.each_char.tally
# result = {}
# letters = ('A'..'Z').to_a + ('a'..'z').to_a

# letters.each do |letter|
#   letter_frequency = statement.count(letter)
#   result[letter] = letter_frequency if letter_frequency > 0
# end
# p result


# # Practice Problem 8

# # numbers = [1, 2, 3, 4]
# # numbers.each do |number|
# #   p number 
# #   numbers.shift(1)
# # end
# # p numbers

# # 1
# # 3
# # # => [1,3]

# numbers = [1, 2, 3, 4]
# p (numbers.each do |number|
#   p number
#   numbers.pop(1)
# end)

# # 1
# # 2
# # => [1, 2]

# # Practice Problem 9

# words = "the flintstones rock"

# def titleize(words)
#   words.split.map { |word| word.capitalize }.join(' ')
# end

# # Split string at spaces
# # Iterate through each word
# # Capitalize the character at index 0 of each word

# p titleize(words) == "The Flintstones Rock"

# Practice Problem 10

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

names = munsters.keys



names.each_with_index do |name, index|
  age = munsters[names[index]]['age']
  case age
  when (0..17)
    munsters[name]['age_group'] = 'kid'
  when (18..64)
    munsters[name]['age_group'] = 'adult'
  else
    munsters[name]['age_group'] = 'senior'
  end
end

p munsters