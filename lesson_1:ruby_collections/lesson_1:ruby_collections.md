# Collection Basics

## Element Reference

### String Element Reference

Works similarly to an array. Letters can be accessed via index numbers, index starts at 0.

```ruby
str = 'abcdefghi'
str[2] # => 'c'
str[2, 3] # => 'cde'  --- first arg is index start point, second arg is how many characters to select
```

The `str[2,3]` above is the same thing as `str.slice(2,3)`, but alternate syntax. "syntactical sugar".

We can method chain just like we would with any other methods:

```ruby
str[2,3][0] # => 'c' --- we access the char at index 2, ask for 3 chars, and then take the 0th index of the new collection
```

Technically strings AREN'T true collections. Collections contain multiple objects, but a string only contains a single object.

String ACT LIKE collections. You can access each char as if it were a collection, but the chars themselves aren't single objects.

When you access a char using the `str[2]` or whatever other syntax, the return is a new string:

```ruby
char1 = str[2]
char2 = str[2]
char1.object_id == char2.object_id # => false
```

This makes sense because it's the same as any other string.

### Array Element Reference

Ordered, zero indexed collections.

```ruby
arr = ['a','b','c','d','e','f','g']
arr[2,3] # => ['c','d','e']
arr[2,3][0] # => ['c']
```

The above is the Array#slice method (note that it's a different method than String#slice, even though they do the same thing).

One key difference is that String#slice returns a new string, where Array#slice returns a new array (duh). But there is one exception:

```ruby
arr = [1, 'two', :three, '4']
arr.slice(3) # => '3' note that it's NOT ['3']
arr.slice(3..3) # => ['3']
arr.slice(3, 1) # => ['3']
```

If you call slice and pass in a single index instead of a start and end point, it'll just return the object itself, not a new array.

Important to know exactly what is getting returned, in this case what data type.

### Hash Element Reference

Instead of integer-based index, uses key-value pairs. Keys and values can be any type of Ruby object.

```ruby
hsh = { 'fruit' => 'apple', 'vegetable' => 'carrot'}

hsh['fruit'] # => 'apple'
hsh['fruit'][0] # => 'a'
```

The above would be an example of method chaining. We first retrieve the value associated w/ `'fruit'`. We then call `[0]` on the return value, which is a string.

When you initialize a hash, keys must be unique. Otherwise the last duplicate key overwrites the previous.

```ruby
hsh = { 'fruit' => 'apple', 'vegetable' => 'carrot', 'fruit' => 'pear' }
# throws a warning and then sets 'fruit' => 'pear', overwrites the first occurence of 'fruit'
```

Values CAN be duplicated. This makes sense. Think about it like if they were all usernames. Two users can have the same password (value), but there cannot be two of the same user (keys).

We can access just the keys or just the values with `#keys` and `#values` methods of `Hash`. These return an array:

```ruby
country_capitals = { uk: 'london', france: 'paris', germany: 'berlin'}
country_capitals.keys # => [:uk, :france, :germany]
country_capitals.values # => ['london', 'paris', 'berlin']
country_capitals.values[0] # method chaining again => 'london'
```

### Element Reference Gotchas

#### Out of Bounds Indices

References an out of bounds index returns `nil`. Confusing because `nil` can be an element in an array.

```ruby
str = 'abcde'
arr = ['a', 'b', 'c', 'd', 'e']
str[5] # => nil
arr[5] # => nil .... but wait is it out of bounds or is the object actually nil?!
arr = ['a', 'b', 'c', 'd', 'e', nil]
arr[5] # => nil
```

The `Array#fetch` method solves for this issue. It tries to return the element at index position, but throws an exception if out of bounds.

```ruby
arr.fetch(5) # => nil
arr.fetch(6) # => IndexError: index 6 out of bounds
```

It's better to use `#fetch` than `#[]` because fetch enforces array boundaries. However `#[]` is probably more common.

#### Negative Indices

You can also access indices from right to left instead of left to right using negative numbers.

Works pretty much the same way, except the last element is -1. From there just count.

#### Invalid Hash Keys

`Hash` also has a `#fetch` method. This is useful because, again, you can have actual `nil` in your hash, or you can be trying to access a key's value that doesn't exist:

```ruby
hsh = {:a => 1, 'b' => 'two', :c => nil}

hsh['b'] # => 'two'
hsh[:c] # => nil   ---- :c's actual value is nil
hsh[:d] # => nil   ---- :d doesn't exist in hsh, so we get a nil
hsh.fetch(:d) # KeyError: key not found
```

## Conversion

The fact that strings and arrays are so similar, allows us to convert back and forth between the two types. Bunch of different methods to do this, two are `String#chars` and `#Array#join`:

```ruby
str = 'Practice'

arr = str.chars # => ['P', 'r', 'a', 'c', 't', 'i', 'c', 'e']

arr.join # => "Practice"
```

Hash also has a way to covert to array called `to_a`. It make sub arrays of key-val pairs. The opposite can also be done, where you take those sub arrays and call `to_h` on them.

## Element Assignment

### String Element Assignment

You can change specific string chars by referring to their index.

```ruby
str = "joe's favorite color is blue"
str[0] = 'J'
str # => "Joe's favorite color is blue"
```

### Array Element Assignment

You can do the same thing with arrays:

```ruby
arr = [1, 2, 3, 4, 5]
arr[0] += 1 # => 2
arr         # => [2, 2, 3, 4, 5]
```

### Hash Element Assignment

In hashes, you can do the same thing, but you need to refer to the keys instead of the indexes:

```ruby
hsh = { apple: 'Produce', carrot: 'Produce', pear: 'Produce', broccoli: 'Produce'}
hsh[:apple] = 'Fruit'
hsh # { apple: 'Fruit', carrot: 'Produce', pear: 'Produce', broccoli: 'Produce'}
```

# Looping

Perform an action on many or all elements within a collection. You can do it manually like this:

```ruby
arr = [1, 2, 3, 4, 5]
arr[0] += 1
arr[1] += 1
arr[2] += 1
arr[3] += 1
arr[4] += 1
arr # => [2, 3, 4, 5, 6]

# or with a loop like this
counter = 0
loop do
  arr[counter] += 1
  counter += 1
  break if counter == arr.size
end
```

## Controlling a Loop

Use the `break` keyword to avoid infinite loops

## Iteration

We can designate a variable that counts the amount of iterations. We then manipulate the variable within the loop to match the number iteration we are currently working on. I have a good grasp on this already.

One tricky point is that counter shouldn't be assigned within the loop. Otherwise you'll reassign it on every iteration.

We can change `if` statements to `if` modifiers. An `if` modifiers is something like `break if this happens`. Only use these if there are not multiple lines of code within the `if` statement.

## Break placement

If `break` is on the last line within the loop, loop mimics `do/while`. "Do this while this is true, then check if it's still true"

- `do/while` executes at least once

If `break` is on the first line within the loop, loop mimics `do`. "While this thing is true (check if it is!), do this thing"

- `while` may not execute at all (if the condition evaluates `false`). Here's an example of the code not running:

```ruby
counter = 0

loop do
  break if counter == 0 # counter does == 0, so break is executed
  puts 'Hello!' # we never get to this
  counter += 1  # or this
end
```

## Next

We can use `next` combined with `if` to skip iterations where a certain condition is met.

```ruby
counter = 0
loop do
  counter +=1
  next if counter.odd? # note that if this was first, it would be infinite loop after first iteration
  puts counter         # reason is because counter == 1 and 1 is odd, so we would never get to the line where we manipulate count
  break if counter > 5 # if this was == 5, that would be infinite as well, because counter will never == 5 per the counter.odd? line
end
```

## Iterating Over Collections

### String

A loop that iterates over a string and prints the char:

```ruby
alphabet = 'abcdefghijklmnopqrstuvwxyz'
counter = 0

loop do
  break if counter == alphabet.size
  puts alphabet[counter]
  counter += 1
end

```

### Array

We can do the same thing we did above, but with an array:

```ruby
colors = ['green', 'blue', 'purple', 'orange']
counter = 0

loop do
  break if counter == colors.size
  puts "I'm the color #{colors[counter]}!"
  counter += 1
end
# I'm the color green!
# I'm the color blue!
# I'm the color purple!
# I'm the color orange!
```

Also can do the same thing if the elements within the array are other object types.

### Hash

We can do the same thing with a hash, but there are extra steps. Remember, we access values by using the hash's key, so a counter won't work. We first need an array, then we can use a counter. How do we get an array?:

```ruby
number_of_pets = { 'dogs' => 2, 'cats' => 4, 'fish' => 1}
pets = number_of_pets.keys # => ['dogs', 'cats', 'fish']
counter = 0

loop do
  break if counter == number_of_pets.size
  current_pet = pets[counter]
  current_pet_number = number_of_pets[current_pet]
  puts "I have #{current_pet_number} #{current_pet}!"
  counter += 1
end
```

### Summary

Loop has four basic parts: a loop, a counter, a way to get the current value, and a way to exit.

You can do pretty much everything you need with just a basic loop. Keep in mind if you don't know a particular method. Solve procedurally if necessary, rather than declaritavely.

# Introduction to PEDAC process

P - understand the problem
E - examples/test cases
D - data structure
A - algorithm
C - code

Saves you time when solving **complex** problems. Some problems are so easy that you don't need it.

## P - [understand the] Problem

1. Read the problem description
2. Check the test cases
3. If any part of the problem is unclear, ask the interviewer or problem requester to clarify the matter

Here's a problem you might come across:

```ruby
# PROBLEM:

# Given a string, write a method change_me which returns the same
# string but with all the words in it that are palindromes uppercased.

# change_me("We will meet at noon") == "We will meet at NOON"
# change_me("No palindromes here") == "No palindromes here"
# change_me("") == ""
# change_me("I LOVE my mom and dad equally") == "I LOVE my MOM and DAD equally"
```

Questions you might ask:

What is a palindrome?

Show the words in the string remain the same if they're already upcase? This is implicit because test case 4 shows this exact scenario

How should I deal with empty strings? Also shown in the test case

Can I assume all inputs are strings?

Should I consider letter case when deciding if a word is a palindrome?

Do I need to return the same string object or a new one? This is an often overlooked question... never thought of this.

Verify assumptions through test cases or asking the interviewer.

## Data Structure / Algorithm

DS influece you algo, and for that reason these are often paired. Biggest problem people run into w/ algo is lack of detail.
Here's an example:

```ruby
# PROBLEM:

# Given a string, write a method `palindrome_substrings` which returns
# all the substrings from a given string which are palindromes. Consider
# palindrome words case sensitive.

# Test cases:

# palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
# palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
# palindrome_substrings("palindrome") == []
# palindrome_substrings("") == []

# INPUT: string
# OUTPUT: array of substrings which are palindromes (case sensitive)
# RULES:
# - always a string input
# - return substrings that are palindromes
# - string can be blank, in which case return an empty array
# - case matters
```

Still on the palindrome problem, here's a high level algorithm for it:

```ruby
# Algorithm:
#  - initialize a result variable to an empty array
#  - create an array named substring_arr that contains all of the
#    substrings of the input string that are at least 2 characters long.
#  - loop through the words in the substring_arr array.
#  - if the word is a palindrome, append it to the result
#    array
#  - return the result array
```

It looks complete, but how do we do step number 2?! That's the hard part and it's not detailed in the algorithm.

If we were to start to code and then get to step number 2 and realize this, we should go back to the algorithm and solve it there first. Train yourself to do it this way. If you started writing the code you might do this:

```ruby
def palindrome_substrings(str)
  result = []
  substrings_arr = substrings(str)
  substring_arr.each do |substring|
    result << substring if is_palindrome?(substring)
  end
  result
```

We write the high level method and any time and we can use functions that we haven't even created yet. It's like we put the placeholder for a lego block that is eventually going to go there once we build the lego block. Once we have this written, we would go back to the algorithm and define the steps that need to take place in order for substrings to get our substring array and is_palindrome? to identify a palindrome.

`substrings` is the harder of the two. Simplify the problem by using small, concrete examples. What if the word was `halo`?:

```ruby
['ha', 'hal', 'halo', 'alo', 'lo']
```

Then think about the pattern and how you could represent that pattern programatically.

```ruby
index[0..1], index[0..2], index[0..-1], index[1..2], index[1..-1]
```

And we need to do this for each word in the string (outer loop). So you might write:

```ruby
# for each starting index from 0 through the next to last index position (because starting at last can't produce a sub w/ length 2)
#   for each substring length from 2 until there are no substrings of that length
#     exract the substring of the indicated length starting at the indicated index position
#   end the inner loop
# end the outer loop
```

The point of this is all to say that you don't have to write out all of your pseudocode before you start coding. You can have layers of abstraction in the pseudocode, and then go back and put it into and algo after you've started coding.

# The PEDAC Problem Solving Process

## P: Understanding the Problem

- Establish the rules/define the boundaries of the problem
  - Assess available information
  - Restate explicit requirement
  - Identify implicit requirements
- Don't rush this step

**General Example**

Given a string, produce a new string with every other word removed.

Explicit requirements:

- Input: string
- Output: new string
- Remove every other word from input string

Questions:

- what do we mean by every other word? all of the odd words? even words?
- how do we define a word in this context? are word delimited by spaces?

the answer to these are the implicit requirements of the problem

## E: Examples and Test cases

- Can confirm/refute assumptions
- Help to answer questions about implicit requirements
- Act as assertions which help to codify the rules and boundaries

## D: Data structures

- Help reason with data logically
- Help interact with data at implementation level
- Thinking in terms of data structures is part of problem sovling process
- DS are closely linked to algorithms
  - Algo is set of steps from input to output
    - Involves structuring data in a certain way

## A: Algorithms

- A logical sequence of steps for accomplishing a task of objective
  - closely linked to data structures
  - series of steps to structure data to produce the required output
- stay abstract and high level
  - avoid implementation detail
  - don't worry about efficiency for now

## C: Implementing a solution in code

- Translating solution algorithm into code
- Think about the algorithm in the context of the programming language
  - Language features and constraints
  - Characteristics of data structures
  - built in functions/methods
  - syntax and coding patterns
- Create test cases
- code with intent

## Sum Even Number Rows

Imagine a sequence of consectuive integes beginning with 2. The integes are grouped in rows, with the first row containing one integer, the second row two integers, the third row three integers, and so on. Given an integer represnting the number of a parrticular row, return an integer representing the sum of all the integers in that row.

**rules and requirements**

- Sequence of even integers
- Sequence begins with 2
- Integers are consecutive
- Sequence is grouped into rows
- Each row is incrementally larger than the previous: 1, 2, 3, 4, ...
- Row 'number' equals number of elements in the row
  - Row 1 has 1 element, row 2 has 2 elements, ...
- Input: a single integer
  - Indentifies a 'row', which is a subset of a sequence of integers
- Output: a single integer

  - The sum of the integers in a row identified by the input integer

- Sequence
  2, 4, 6, 8, 10, 12, 14, 16, 18, ...

2
4, 6
8, 10, 12
14, 16, 18, 20

- How do we create the structure?

**examples**
row number: 1 --> sum of integers in row: 2
row number: 2 --> sum of integers in row: 10
row number: 4 --> sum of integers in row: 68

2 --> 2
4, 6 --> 10
8, 10, 12
14, 16, 18, 20 --> 68

**Data Structure**

- Overall structure represents a sequence as a whole
- Individual rows within overall structure
- Individual rows in a set order in context of sequence
- Individual rows contain integers
- Can assume that integers are in a set order in the context of the sequences

[
[2]
[4, 6],
[8, 10, 12],
[14, 16, 18, 20],
...
]

**algorithm**

1. create an empty 'rows' array to contain all of the rows
2. create a 'row' array and add it to the overall 'rows' array
3. repeat step 2 until all the necessary rows have been created
   - all rows have been created when the length of the rows array is equal to the input integer
4. sum the final row
5. return the sum of the final row

Problem: create a row

Rules:

- row is an array
- array contains integers
- integers are consecutive even numbers
- integers in each row form part of an overall sequence
- rows are different lengths
- Input: the information needed to create the output
  - The starting integer
  - The length of the row
- Output: the row itself `[8,10,12]`

Examples:
start: 2, length: 1 --> [2]
start: 4, length: 2 --> [4, 6]
start: 8, length: 3 --> [8, 10, 12]

Data structures:

- an array of integers

Algorithm:

1. create an empty row to contain the integers
2. add the starting integer
3. increment the starting integer by 2 to get the next integer
4. repeat steps 2 and 3 until the array has reached the correct length
5. return the array

# Selection and Transformation

Selection - picking certain elements out of collection based on criteria
Transformation - manipulating every element in the collection

## Looping to Select and Transform

Example of selection:

```ruby
alphabet = 'abcdefghijklmnopqrstuvwxyz'
selected_char = ''
counter = 0

loop do
  current_char = alphabet[counter]

  if current_char == 'g'
    selected_chars << current_char
  end

  counter += 1
  break if counter == alphabet.size
end

selected_char
# => 'g'
```

The `if current_char == 'g'` is called the `selection criteria`.

Example of transformation:

```ruby
fruits = ['apple', 'banana', 'pear']
transformed_elements = []
counter = 0

loop do
  current_element = fruits[counter]

  transformed_elements << (current_element + 's')

  counter += 1
  break if counter == fruits.size
end
transformed_elements
# => ['apples', 'bananas', 'pears']
```

The `transformed_elements << (current_element + 's')` is the `transformation criteria`.

Always keep in mind if your returning a new array, or returning the same array but mutated. In this case, we're returning a new array.

## Extracting to Methods

A point that is hit on a few times in this section is knowing whether your method is mutating or not. Keep that in mind.

## More flexible methods

Earlier we looked at a a method that selected all the key value pairs from a produce hash whose value was "Fruit" (did it in test.rb). It had the commented line in the following code. We can make that method more flexible by adding an additional parameter and then testing against that parameter instead of `fruit`. Seen below:

```ruby
def general_select(produce_list, selection_criteria)
  produce_keys = produce_list.keys
  counter = 0
  selected_produce = {}

  loop do
    break if counter == produce_keys.size

    current_key = produce_keys[counter]
    current_value = produce_list[current_key]

    # used to be current_value == 'Fruit'
    if current_value == selection_criteria
      selected_produce[current_key] = current_value
    end

    counter += 1
  end

  selected_produce
end
```

# The #each, #map, and #select Methods

There's an easier way to loop than the `loop` and `for` we've been working with so far...

## Each

`each` is basically the same as `loop` except it takes care of the `counter`, the `break`, and the manipulation of the `counter` for us. Here's an example:

```ruby
[1,2,3].each do |num|
  put num
end
```

The block knows what `num` is because `each` sends the value of the current element to the block in the form of an argument. In the case above, the block's argument is `num` and `num` represents the value of the current element in the array.

In the case of an array, `each` knows there's only one element per iteration. Contrast to hashes which require two arguments for key and value:

```ruby
hash = {a:1,b:2,c:3}
hash.each do |key, value|
  puts "The key is #{key} and the value is #{value}"
end

# or with loop
hash = {a:1,b:2,c:3}
counter = 0
hash_keys = hash.keys
new_hash = {}
loop do
  current_key = hash_keys[counter]
  new_hash[current_key] = hash[current_key]
  counter += 1
  break if counter == hash_keys.size
end
new_hash
```

The main difference between iteration with `each` and `loop` is the return value. `each` returns the original array.

Tricky thing on this:

```ruby
def a_method
  [1,2,3].each do |num|
    puts num * 2
  end
end # => [1,2,3]

# because the last line executed is the `.each` but:

def a_method
  [1,2,3].each do |num|
    puts num * 2
  end

  puts num
end # => nil

# because we added a puts after the each call
```

## Select

We can do selection with a `loop`, but we can also use Ruby's built in way: `select`. Again, it manages the `counter` and the `break` for us:

```ruby
[1,2,3].select do |num|
  num.odd?
end
```

`select` evaluates the return value of the block. The block returns a value on each iteration, that value gets evaluated by `select`.

`select` cares about _truthiness_. Does passing in `num` to whatever expression we have within the block return a truthy value? If it does, select `num`. Note that we're not using the expression to CHANGE `num` in this case. We are ONLY concerned about the return value of `num` passed into the expression:

```ruby
[1,2,3].select do |num|
  num - 100
end # => 1,2,3   .... note that we're not subtracting num-100 and returning that value.
    #                 select evaluates that expression, and looks at its truthiness, returns it if true so:
[1,2,3].select do |num|
  num = nil
end # => [] or...
[1,2,3].select do |num|
  puts num
end # => [] because puts num returns `nil` which is falsy
```

## Map

`map` also considers the return value of the block. But `map` uses the return value to perform transformation instead of selection.

`map` returns a **new collection** where the expression in the block is evaluated with the block's argument passed to it. The return value is added to a new collection.

```ruby
[1,2,3].map do |num|
  num * 2 # the return value for `num` on each iteration gets added to the new collection we're going to return
end # [2, 4, 6]

# if we write code in the block that is not a transformation instruction/is a selection instruction, we get weirdness. Remember, we care about the return values:
[1,2,3].map do |num|
  num.odd? # the return value is going to be either `true` or `false`
end # => [true, false, true] ... and so we get a return array full of `true` and `false`

# or this:

[1,2,3].map do |num|
  puts num # => return value is `nil`
end # => [nil, nil, nil]

# or this:

[1,2,3].map do |num|
  "hey"
end # => ["hey", "hey", "hey"]
```

### Enumerable

`select` and `map` are defined in a module called Enumerable, which is available to `Array` and `Hash` classes.

Not super important to dive deep at this point, just general awareness.

## Summary

Useful chart here, copied into notebook.

# More Methods

This section is about deconstructing common built-in collection oriented methods.

## Enumerable#any?

Takes a block, and evaluates the truthiness of the block's return value for each argument passed into it:

```ruby
[1,2,3].any? do |num|
  num > 2
end # => true  ... if any of the `num > 2`'s have a truthy return value, the block evaluates to `true`
```

Can also use a hash

```ruby
{a: 'ant', b: 'bear', c: 'cat'}.any? do |key, value|
  value.size > 4
end # => false
```

## Enumerable#all?

Works similar to `any?`. Only difference is, it only returns `true` if **all** the iteration return values are truthy.

```ruby
[1,2,3].all? do |num|
  num > 2
end # => false

# and on a hash:

{a:'ant', b:'bear', c:'cat'}.all? do |key, value|
  value.length >= 3
end
```

## Enumerable#each_with_index

Nearly identical to `each`, except `each_with_index` takes another argument, which represents the index of each element.

```ruby
[1,2,3].each_with_index do |num, index|
  puts "The index of #{num} is #{index}."
end

# The index of 1 is 0.
# The index of 2 is 1.
# The index of 3 is 2.

# If you call it on a hash, the first argument is an array with key/val pair and the second is the index of the array

{a:'ant', b:'bear', c:'cat'}.each_with_index |pair, index|
  puts "The index of #{pair} is #{index}."
end

# The index of [:a, 'ant'] is 0.
# The index of [:b, 'bear'] is 1.
# The index of [:c, 'cat'] is 2.

```

`each_with_index` returns the original collection (same as `each`)

## Enumerable#each_with_object

`each_with_object` takes a method argument. The method argument is a collection object that gets returned by the method. The block takes 2 arguments. First is the current element and the second is the collection object that was passed in as an argument:

```ruby
[1,2,3].each_with_object([]) do |num, array|
  array << num if num.odd?
end # => [1,3]

# and if you call it on a hash

{a:'ant', b:'bear', c:'cat'}.each_with_object([]) do |pair, array|
  array << pair.last
end # => ['ant', 'bear', 'cat']

# or we can use parentheses to capture key and value:

{a:'ant', b:'bear', c:'cat'}.each_with_object({}) do |(key,value), hash|
  hash[value] = key
end # => {'ant' => :a, 'bear' => :b, 'cat' => :c}
```

Stick to one format.

## Enumerable#first

`first` doesn't take a block, but does take an argument to specify how many elements to return. If no arg is passed to it, it just gives you the first. If you pass it `x` it'll give you the first `x` elements:

```ruby
[1,2,3].first #=> 1

# or on a hash:

{a:'ant', b:'bear', c:'cat'}.first(2)
# => [[:a, 'ant'], [:b, 'bear']]
```

Hashes are usually thought of as unordered. Some programming languages don't preserve the order, but Ruby does. With that said, calling `first` on a hash doesn't really make sense.

Also, the return is a nested array. We can simply call `to_h` on it to transform it back to a hash though.

`first` doesn't really get called on arrays in practice.

## Enumerable#include?

`include?` takes an argument and returns `true` if the argument exists in the collection and `false` if not.

If you call it on a hash, it only checks keys, not values.

```ruby
[1,2,3].include?(1) # => true

{a:'ant', b:'bear', c:'cat'}.include?("ant")
# => false ... remember, only keys

{a:'ant', b:'bear', c:'cat'}.include?(:a)
# => true
```

`Hash#include?` is the same as `Hash#key?` or `Hash#has_key?`. Prefer the latter 2 over the former 1 because the intention is more explicit. You can use `Hash#value?` for values.

## Enumerable#partition

Divides elements in the current collection into two collections based on the block return value. Using parallel assignment here is useful because you can actually capture the two different return sub arrays into their own variables:

```ruby
odd, even = [1,2,3].partition do |num|
  num.odd?
end # => [[1,3], [2]]

# or on a hash:

long, short = {a:'ant', b:'bear', c:'cat'}.partition do |key, value|
  value.size > 3
end # [[[:b, "bear"]], [[:a, "ant"], [:c, "cat"]]]
long # => [[:b, "bear"]]
long.to_h # => {:b=>"bear"}
# same with short
```

## Summary

Method docs are good for finding and understanding these and others. They usually include:

- One+ method signatures (does it take an arg or block, what does it return)
- How it's used, use cases
- Examples
