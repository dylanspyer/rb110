#Runaway Loop

# loop do
#   puts 'Just keep printing...'
#   break
# end

# # Loopception

# loop do
#   puts 'This is the outer loop.'

#   loop do
#     puts 'This is the inner loop.'
#     break
#   end
#   break
# end

# puts 'This is outside all loops.'

# # Control the Loop

# iterations = 1

# loop do
#   puts "Number of iterations = #{iterations}"
#   iterations += 1
#   break if iterations > 5
# end

# # Loop on Command

# loop do
#   puts 'Should I stop looping?'
#   answer = gets.chomp
#   break if answer == 'yes'
# end

# # Say Hello

# say_hello = true
# count = 0
# while say_hello
#   puts 'Hello!'
#   count += 1
#   say_hello = false if count == 5
#   end
# end

# # Print While
# numbers = []

# while numbers.length < 5
#   numbers << rand(100)
# end

# p numbers

# # Count Up

# count = 1

# until count > 10
#   puts count
#   count += 1
# end

# # Print Until
# numbers = [7, 9, 13, 25, 18]

# index = 0

# until index == numbers.length 
#   puts numbers[index]
#   index += 1
# end

# # That's Odd

# for i in 1..100
#   puts i if i.odd?
# end

# # Greet your friends

# friends = ['Sarah', 'John', 'Hannah', 'Dave']

# for friend in friends
#   puts "Hello, #{friend}"
# end