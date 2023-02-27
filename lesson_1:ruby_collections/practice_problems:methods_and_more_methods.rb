# Practice problem 1

[1, 2, 3].select do |num|
  num > 5
  'hi'
end
# [1, 2, 3]
# remember - select DOES NOT TRANSFORM!!!

# Practice Problem 2

['ant', 'bat', 'caterpillar'].count do |str|
  str.length < 4
end
# => 2
# Count returns the elements for which the block returns a truthy value
# It's kind of like select, except instead of returning an array of elements that meet the condition, 
# it returns a count of values that meet the condition

# Practice Problem 3

[1, 2, 3].reject do |num|
  puts num
end # => [1, 2, 3]

# Reject cares about falsy values. Returns a new array that contains items where the block's retrun value is falsy (false or nil).
# puts num always evaluates nil, so all the num's are selected.

# Practice Problem 4

['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end # {'a' => 'ant', 'b', => 'bear', 'c' => 'cat'}

# Practice Problem 6

['ant', 'bear', 'caterpillar'].pop.size # => 11

# Practice Problem 7

[1, 2, 3].any? do |num|
  puts num
  num.odd?
end 
# 1
# => true
# any? uses short circuit evaluation, meaning it sees 1.odd? evaluates true and it stops evaluation at that point.
# so we only get puts num once

# Practice Problem 8

arr = [1, 2, 3, 4, 5]
arr.take(2)

# #take returns the first arg amount of elements, it's not destructive
# if it was destructive, the docs would indicate that by showing that the same object is being returned
# we should also check in a repl like irb

# Practice Problem 9

{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end # => [nil, 'bear'] when none of the conditions of an `if` statement evaluate `true`, `nil` is returned

# Practice Problem 10

[1, 2, 3].map do |num|
  if num > 1
    puts num
  else
    num
  end
end # => [1, nil, nil]

# Key points
# How does the method treat the block's return value? Does it care about truthiness?
# What is the return value?
# How can you use Ruby docs to learn more?
# Is the method destructive?