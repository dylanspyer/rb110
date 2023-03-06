## Practice Problem 1

# arr = ['10', '11', '9', '7', '8']

# p arr.map(&:to_i).sort { |a,b| b <=> a }.map(&:to_s)

# p (arr.sort do |a, b|
#   b.to_i <=> a.to_i
#   end)

## Practice Problem 2

# books = [
#   {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
#   {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
#   {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
#   {title: 'Ulysses', author: 'James Joyce', published: '1922'}
# ]

# p books.sort_by { |book| book[:published] }

## Practice Problem 3

# arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]

# p arr1[2][1][3]

# arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]

# p arr2[1][:third][0]

# arr3 = [['abc'], ['def'], {third: ['ghi']}]

# p arr3[2][:third][0][0]

# hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}

# p hsh1['b'][1]

# hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}

# p hsh2[:third].key(0)

## Practice Problem 4

# arr1 = [1, [2, 3], 4]

# # arr1[1][1] = 4
# # p arr1

# arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]

# # arr2[2] = 4
# # p arr2

# hsh1 = {first: [1, 2, [3]]}

# # p hsh1[:first][2][0] = 4
# # p hsh1

# hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}

# # hsh2[['a']][:a][2] = 4
# # p hsh2

## Practice Problem 5

# munsters = {
#   "Herman" => { "age" => 32, "gender" => "male" },
#   "Lily" => { "age" => 30, "gender" => "female" },
#   "Grandpa" => { "age" => 402, "gender" => "male" },
#   "Eddie" => { "age" => 10, "gender" => "male" },
#   "Marilyn" => { "age" => 23, "gender" => "female"}
# }

# p (munsters.each_with_object([]) do |name, arr|
#   if name[1]["gender"] == "male"
#     arr << name[1]["age"]
#   end
# end.sum)

# total_male_age = 0
# munsters.each_value do |details|
#   total_male_age += details["age"] if details["gender"] == "male"
# end
# p total_male_age

## Problem 6

# munsters = {
#   "Herman" => { "age" => 32, "gender" => "male" },
#   "Lily" => { "age" => 30, "gender" => "female" },
#   "Grandpa" => { "age" => 402, "gender" => "male" },
#   "Eddie" => { "age" => 10, "gender" => "male" },
#   "Marilyn" => { "age" => 23, "gender" => "female"}
# }

# munsters.each do |name, hash|
#   puts "#{name} is a #{hash["age"]}-year-old #{hash["gender"]}."
# end

##Practice Problem 7

# a = 2
# b = [5, 8]
# arr = [a, b]
# # arr => [2, [5, 8]]

# arr[0] += 2 # this doesn't change the value of `a`
#             # `a` and `arr[0]` both point at the same object
#             # we reassign `arr[0]` a new object
# # => [4 [5, 8]]
# # a => 2
# arr[1][0] -= a
# # => [4 [3, 8]]

# Practice Problem 8

# hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

# hsh.each do |_, v|
#   v.each do |words|
#     words.each_char { |char| puts char if char.match?(/[aeiouAEIOU]/)}
#   end
# end

##Practice Problem 9

# arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

# p (arr.map do |sub_arr|
#   sub_arr.sort { |a, b| b <=> a}
# end)

##Practice Problem 10
# arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

# p (arr.map do |hash|
#   hash.each.with_object({}) do |(k, v), new_hash|
#     new_hash[k] = v + 1
#   end
# end)

# p arr

## Practice Problem 11

# arr = [[2], [3, 5, 7, 12], [9], [11, 13, 15]]

#     p (arr.map do |sub_arr|
#         (sub_arr.select do |num|
#           num % 3 == 0
#         end)
#       end)

# I want to return a new array (map)
# Where I filter out elements that don't pass a condition (select)

## Practice Problem 12

# arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]
# # expected return value: {:a=>1, "b"=>"two", "sea"=>{:c=>3}, {:a=>1, :b=>2, :c=>3, :d=>4}=>"D"}'

#  p  (arr.each_with_object({}) do | arr, hash |
#       hash[arr[0]] = arr[1]
#     end) == {:a=>1, "b"=>"two", "sea"=>{:c=>3}, {:a=>1, :b=>2, :c=>3, :d=>4}=>"D"}


## Practice Problem 13

# arr = [[1, 6, 9], [6, 1, 7], [1, 8, 3], [1, 5, 9]]
# [[1, 8, 3], [1, 5, 9], [6, 1, 7], [1, 6, 9]]
# => [[1, 3], [1, 5, 9], [1, 7], [1, 9]]

## sort the array as if the even numbers aren't there
##return the sorted array with the even numbers there
## sort an array of odd arrays

    # p (arr.sort_by do |sub_arr|
    #     sub_arr.select do |num|
    #       num.odd?
    #     end
    #   end)

## Practice Problem 14

# hsh = {
#   'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
#   'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
#   'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
#   'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
#   'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
# }

# p (hsh.map do |k, v|
#     if v[:type] == 'fruit'
#       v[:colors].map(&:capitalize)
#     elsif v[:type] == 'vegetable'
#       v[:size].upcase
#     end
#   end) #== [["Red", "Green"], "MEDIUM", ["Red", "Green"], ["Orange"], "LARGE"]

## Practice Problem 15

# arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

#  p  (arr.select do |hash|
#       hash.all? do |key, num_arr|
#         num_arr.all? do |num|
#           num.even?
#         end
#       end
#     end)

## Practice Problem 16

# INPUT: nothing
# OUTPUT: a random UUID number (string)
# RULES:
# - num has 4 sections broken down as 8-4-4-4-12 digits for ea section
# - digits can be hexadecimal (what's that?)
#   - 0-9
#   - a-f
# algo:
# - initialize a section array that holds the amount of nums per section
# - initilaize possibilities array
# - iterate thru section array
#   - for a section number of times, generate a random hexadecimal number from possibilities
#   - store that number in a result string
#   - push string to array
#   - reset string
# - join the array on "-"

# def uuid
#   possibilities = (0..9).to_a + ('a'..'f').to_a
#   sections = [8, 4, 4, 4, 12]
#   result = []
#   section = ''
#   sections.each do |num|
#     num.times do
#       section << possibilities.sample.to_s
#     end
#     result << section
#     section = ''
#   end
#   result.join('-')
# end

# uuid

