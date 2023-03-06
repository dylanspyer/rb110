# Sorting

Talked about selection and transformation so far.

Now looking at sorting in some kind of order. Mostly deals with arrays (strings don't have access to these methods, but you can convert to array first. Hashes don't normally need to be sorted because values can be accessed by their key).

## What is Sorting?

Setting order according to some criteria.

The "brute force" way to sort (without built in methods) isn't as simple as the brute force way to do selection and transformation (IE with loops).

It's possible, but not in scope for now.

We're looking at `sort` and `sort_by`.
`[2,5,1,6].sort # => [1,2,5,6]`

## Comparison

The algo under any sorting is basically just comparing items in a collection with each other and ordering based on the result.

Calling `sort` on an array returns a new array. If chars of the same case, ordered alphabetically:
`['c', 'a', 'e', 'b', 'd'].sort # => ['a', 'b', 'c', 'd', 'e']

Obvious to us why it's ordered this way, but how does Ruby know?

Spaceship operator `<=>`

## The `<=>` method

Performs comparison between 2 objects of the same type and return `-1` `0` or `1` depending on if the first object is less than, equal to, or greater than the second object. If they cannot be compared, `nil` gets returned.

```ruby
2 <=> 1     # => 1
1 <=> 2     # => -1
2 <=> 2     # => 0
'b' <=> 'a' # => 1
'a' <=> 'b' # => -1
'b' <=> 'b' # => 0
1 <=> 'a'   # => nil
```

So `sort` uses the return value of `<=>` and if the spaceship returns `nil`, sort throws an error:

```ruby
['a', 1].sort # => ArgumentError: comparison of String with 1 failed
```

To understand how `sort` will work for a particular object, you have to know how `<=>` will work for that same object.

Specifically you have to know:

1. Does that object type implement a `<=>` comparison method?
2. If yes, what is the specific implementation of that method for that object (strings implement the spaceship differently than integers)

Strings use the ASCII table.

One thing to note is capital letters come before lowercase letters on the ASCII table (aka they have lower numbers associated with them)

`'A' <=> 'a' # => -1`

All chars have an ASCII value. `!` precedes `A` in the ASCII table:

`!' <=> `A` # => -1

You can use `.ord` to determine the ASCII position of a character.

`b.ord # => 98`
`}.ord # => 125`
so that means:
`'b' <=> '}'` # => -1

### Useful Rules to Remember

- Uppercase letters come before lowercase letters
- Digits and most punctuation come before letters
- There is an extended ASCII table containing accented and other characters - this comes AFTER the main ASCII table

## The sort method

We can also call `sort` with a block. This gives us more control over how items are sorted:

```ruby
# The following would be the same as if we just called sort with no block:
[2,5,3,4,1].sort { |a, b| a <=> b}
# But you can also do this:
[2,5,3,4,1].sort { |a, b| b <=> a}
# Which will reverse the order that you sort. For example:
# a = 2
# b = 5
# 5 <=> 2 # => 1
# Whereas if we did a <=> b
# 2 <=> 5 # => -1
```

You can write any additional code in the block, as long as the block returns -1, 0, 1, or nil.

You can also call sort on arrays (which also uses the spaceship `<=>` operator)

```ruby
[['a', 'cat', 'b', 'c'], ['b', 2], ['a', 'car', 'd', 3], ['a', 'car', 'd']].sort
# => [['a', 'car', 'd'], ['a', 'car', 'd', '3'], ['a', 'cat', 'b', 'c'], ['b', 2]]
#                     <=>                       <=>                     <=>
#                      -1                        -1                      -1
```

Each object in each array is compared element by element. 'a' is before 'b', so the sub array that starts with 'b' is the "largest".

Note on example above - no error thrown even though `['b', 2]` contains an integer. It's the same concept as short circuiting. Ruby sees that the sub array starts with a `'b'` and it stops looking at it because the rest of the sub arrays it's sorting against start with `'a'` so it doesn't need any more information to determine that `['b', 2]` is the largest sub array.

The comparison between `['a', 'car', 'd' 3]` and `['a', 'car', 'd']` is a little trickier b/c the 3 does come into play BUT it's value is not actually being compared to something. Only that fact that it's there (Ruby looks at the length of the string if everything else is equal up until that point).

## The sort_by method

`sort_by` is similar ot sort, but usually called with a block.

```ruby
['cot', 'bed', 'mat'].sort_by { |word| word[1]} # says sort by the character at index 1
# => ['mat', 'bed', 'cot']
```

This example would ignore every other character except the one at index 1.

Generally you don't need to sort hashes, but if you wanted to you would need 2 arguments -- key and value (same as iterating through a hash).

```ruby
people = { Kate: 27, john: 25, Mike: 18 }
people.sort_by { | _ , age | age }
# => [[:Mike, 18], [:john, 25], [:Kate, 27]]
```

Notice the return value is an array. `sort_by` always returns an array. Can call `to_h` if needed.

Can also sort the above array by name, even though they're symbols. Ruby first calls `to_s`, then sorts.
So you're basically just sorting as if the symbols were strings.

But keep in mind that upcase letters have a LOWER ASCII value than downcase letters. That makes `'K' <=> 'j'` -1. Which pushes Kate to the left and john to the right.
Can fix by calling `capitalize` and then calling sort after (or any casing method that makes all the cases the same `upcase` or `downcase`):

```ruby
people.sort_by { |name, _| name.capitalize }
```

There's also destructive `sort!` and `sort_by!`. You can only use these on arrays. Mutates the array to the sorted version of itself (same as regular methods, but mutates the caller).

## Other methods which use comparison

- `min`
- `max`
- `minmax`
- `min_by`
- `max_by`
- `minmax_by`

These are stored in Enumerable which means they are accessible by both arrays and hashes.

# Nested Data Structures

Pretty common for collections to contain collections. Here's examples.

## Referencing collection elements

```ruby
arr = [[1, 3], [2]]
arr[0][0] # => 1
```

Each inner array has its own index even though it's inside another array.

Seen above, we chain element references to access elements within the inner array.

## Updating collection elements

```ruby
arr = [[1,3], [2]]
arr[1] = 'hi there'
arr #=> [[1,3], 'hi there']
```

We can see that even though this looks like assignment, it's not. And it's destructive.
String literal `'hi there'` replaces the entire array `[2]` in the example above.

We can also modify values of a nested array:

```ruby
arr = [[1,3], [2]]
arr[0][1] = 5
arr # => [[1,5], [2]]
```

Looks like reference, but is actually array element update (remember, it's destructive).
First part `arr[0]` is reference and second part `[1] = 5` is update. It's like saying:
`[1,3][1] = 5`

We can also add objects to collections:

```ruby
arr = [[1], [2]]

arr[0] << [3]
arr #=> [[1, [3]], [2]]
# that gives us a 3 layer nested array
# or if you just wanted to add a number

arr = [[1], [2]]
arr[0] << 3
arr #=> [[1,3], [2]]
```

## Other nested structures

We can also nest hashes in an array:

```ruby
arr = [{a:'ant'}, {b:'bear'}]
arr[0] #=> {a:'ant'}
arr[1] #=> {b:'bear'}
```

We can add new key value pairs in a similar way to how we added to nested arrays. First we access the nested collection, then make the assignment.

```ruby
arr = [{a:'ant'}, {b:'bear'}]
arr[0][:c] = 'cat'
arr # => [{a:'ant', c:'cat'},{b:'bear'}]
```

## Variable reference for nested collections

Can be tricky if variables reference inner collections directly:

```ruby
a = [1,3]
b = [2]
arr = [a, b]
arr #=> [[1,3],[2]]
```

Then if you modify `a` after it's already in the array:

```ruby
a[1] = 5
arr #=> [[1,5], [2]]
```

This might seem tricky, but it follows all the pass by reference rules we already learned about. Diagram this out in notebook.

You can also modify `arr` directly, and it does the same thing:

```ruby
arr[0][1] = 8
arr #=> [[1,8], [2]]
```

This is because it's the same object!
`arr[0][1].object_id == a[1].object_id`
` #=> true`

This is an example of variables as pointers. Different variables can be pointing at the same object, and if you mutate that object, you change the value held by both of those variables.

## Shallow Copy

Sometimes you need to copy an entire collection, usually before you perform some modification. Ruby uses `dup` and `clone` for this.

These methods create a _shallow copy_ of the object. This means that only the object that the method is called on is copied. If the object contains other objects, like a nested array, those objects will be shared, not copied.

This seems to be mainly for nested collections.

```ruby
arr1 = ['a','b','c']
arr2 = arr1.dup
arr2[1].upcase!

arr2 # => ['a','B','c']
arr1 # => ['a','B','c']
```

`upcase!` changed both arrays, which initially doesn't make sense (aren't we changing a duplicate?). The reason:

`upcase!` was called on the object _within_ the array, rather than the array itself. Remember, those objects within the array are shared.

More examples:

```ruby
arr1 = ['a','b','c']
arr2 = arr1.dup
arr2.map! do |char|
  char.upcase
end
arr1 # => ['a','b','c']
arr2 # => ['A', 'B', 'C']

# or contrast with this:
arr1 = ['a','b','c']
arr2 = arr1.dup
arr2.each do |char|
  char.upcase!
end
arr1 # => ['A','B','C']
arr2 # => ['A','B','C']
```

First example `arr2` is changed, but not `arr1`. This is because `map!` modifies the array, **replacing each element with a new val**.

Whereas second example, we call a destructive `upcase!` on each **individual element** in the array. `arr1` and `arr2` both point to those objects. Every element in `arr2` is a reference to the object referenced by the corresponding element in `arr1`.

Be aware of what level you're working at, especially with nested collections. Are you at the collection level or the elements within the collection level.

## Freezing objects

Main difference between `dup` and `clone` is that `clone` preserves the frozen state of the object.

```ruby
arr1 = ['a','b','c'].freeze
arr2 = arr1.clone
arr2 << 'd'
# => Error: can't modify frozen array

arr1 = ['a','b','c'].freeze
arr2 = arr1.clone
arr2 << 'd'
arr2 # => ['a','b','c', 'd']
arr1 # => ['a','b','c']
```

In Ruby, objects can be frozen to prevent them from being modified. Only mutable objects can be frozen, because immutables are already frozen.

```ruby
str = 'abc'.freeze
str << 'd'
# => Error: can't modify frozen string

# Check if it's frozen with the `frozen?` method
5.frozen? # => true

```

`freeze` only freezes the object it's called on. If that object is a collection, the items in the collection won't be frozen unless we explicitly freeze them. Example if we have nested array, we can still modify the elements in the array if we freeze the outer array:

```ruby
arr = [[1],[2],[3]].freeze
arr[2] << 4
arr # => [[1],[2],[3,4]]

# applies to strings too:

arr = ['a','b','c'].freeze
arr[2] << 'd'
arr # => ['a','b','cd']

```

## Deep copy

No built in way to create a deep copy or deep freeze objects within objects. Remember the level within the collection that you are working.

# Working with Blocks

## Example 1

```ruby
[[1, 2], [3, 4]].each do |arr|
  puts arr.first
end
# 1
# 3
# => [[1, 2], [3, 4]]

# We loop through each sub arr in the main arr and initialize those sub_arrays to `arr`
# We call puts and pass in Array#first on each of those sub arrays
# We output the first value in each sub array
# We return the nested array because `each` returns the object it was called on
```

Here's some questions to think through when parsing code:

- What is the type of action being performed (method call, block, conditional, etc)?
- What is the object that action is being performed on?
- What is the side effect of that action (output? destructive action?)?
- What is the return value of that action?
- Is the return value used by whatever instigated that action?

## Example 2

```ruby
[[1, 2], [3, 4]].map do |arr|
  puts arr.first
end
# 1
# 3
# => [nil, nil]

# We call map on the main array and pass it a block
# We initialize each element (the 2 sub arrays) within the main array to `arr`
# We call `puts` and pass in `arr.first` on each of the sub arrays.
  # `puts` outputs the argument and returns nil, which is important because `map` cares about return values
# An array with transformed elements based on the block's return value is returned - in this case each block returned `nil`
# so we return an array of `nil`'s [nil,nil]

```

## Example 3

```ruby
[[1, 2], [3, 4]].map do |arr|
  puts arr.first
  arr.first
end

# We call map on an array of sub arrays and pass map a block
# We initialize a variable `arr` to equal each element in the iteration
  # On the first iteration, arr = [1, 2]
  # On the second iteration, arr = [3, 4]
# Within the block, we call `puts` and pass in the method call `arr.first`
  # This returns `nil` and prints the element at index 0 to the console. Return value for this line isn't important because there is another line after it
# Finally, we call `first` on `arr`. This will be the return value for the block.
# `map` returns a new array based on the return value of the block you pass it
  # in this case, the first iteration looks like this --> arr.first --> [1, 2].first --> 1
  # and the second iteration looks like this          --> arr.first --> [3, 4].first --> 3
  # `map` returns an array with these return values in it:
# [1, 3]
# In summary, the code will output 1, 3 and return [1, 3] as follows:
# 1
# 3
# => [1, 3]

```

## Example 4

```ruby
my_arr = [[18, 7], [3, 12]].each do |arr|
  arr.each do |num|
    if num > 5
      puts num
    end
  end
end

# We initialize a variable `my_arr` to equal the return value of calling `each` on an array of sub arrays and passing it a block
# We call `each` on the array [[18, 7], [3, 12]].
# On each iteration, we initialize variable `arr` to equal the elements we are looping through (the sub arrays [18, 7] and [3, 12])
  # Within our first loop, we call the `each` method on each `arr` and initialize variable `num`. This is an inner loop.
  # `num` will be each element within `arr`
    # In the inner loop, we check if `num` is > 5
    # If it is, we output the value of `num` to the console
    # We do this for each `num` in `arr`
    # Then, the outer loop moves onto its next iteration, sets a new `arr`, and we repeat the inner loop's process on that `arr`
      # return value of the inner `each` is [3, 12], but we don't use it for anything
      # return value of the inner block is nil
# return value of the outer loop [[18, 7], [3, 12]] because `each` returns the object it was called on
  # we use it to set hte value of my_arr
# In summary, we are printing 18, 7, and 12 to the console; then returning [[18, 7], [3, 12]]
# 18
# 7
# 12
# => [[18, 7], [3, 12]]


# 4 return values:
# - outer call to each => [[18, 7], [3, 12]]
# - inner call to each => [3, 12]
# - outer block        =>
# - inner block        => nil
```

## Example 5

```ruby
[[1, 2], [3, 4]].map do |arr|
  arr.map do |num|
    num * 2
  end
end

# We call `map` on [[1, 2], [3, 4]]
# We initialize `arr` to be the elements within our collection (in this case the sub arrays [1, 2] on first iteration and [3,4] second)
  # Return value of map is a transformation based on the return value of it's block
  # Within our first call to `map`, we call `map` again on `arr`
  # We initialize `num` to be the elements within `arr`
    # We perform a transformation on `num` - num * 2
    # The return value of the inner `map` is an array with each `num` in each transformed:
      # [[2,4],[6, 8]]
```

## Example 6

```ruby
[{ a: 'ant', b: 'elephant' }, { c: 'cat' }].select do |hash|
  hash.all? do |key, value|
    value[0] == key.to_s
  end
end
# => [{ :c => "cat" }]

# We call `select` on an array, with 2 sub elements (both hashes). We initialize the variable `hash`
# to be the hash in each respective iteration of `select`. We then call `all?` on `hash`, which tests if all the elements within the
# respective hash have letters at the first character (0th index) of the value are equal to the key in string form.
# The outer `select` returns a new array based on the truthiness of the return value of its block's expression
# The inner block in this case evaluates to false on the first iteration, and evaluates to true on the second.
# Outer method return - array based on the truthiness of its block
# Outer block return  - true or false
# Inner method return - true or false
# Inner block return  - true or false
# If you changed `all?` to `any?`, the return value for the entire expression would include both sub arrays
```

## Example 7

## Example 8

## Example 9

```ruby
[[[1], [2], [3], [4]], [['a'], ['b'], ['c']]].map do |element1|
  element1.each do |element2|
    element2.partition do |element3|
      element3.size > 0
    end
  end
end

# => [[[1], [2], [3], [4]], [["a"], ["b"], ["c"]]]
```

## Example 10

```ruby
[[[1, 2], [3, 4]], [5, 6]].map do |arr|
  arr.map do |el|
    if el.to_s.to_i == el   # it's an integer
      el + 1
    else                    # it's an array
      el.map do |n|
        n + 1
      end
    end
  end
end

# Outer array
# 2 inner sub arrays, one that is an outer array itself, and one that is only 1 layer deep
# The first `map` initializes `arr`. `arr` will be each of the sub-arrays: `[[1,2],[3,4]]` and `[5,6]`
# The second `map` initializes `el`. `el` will be `[1,2], [3,4], 5, 6` respectively
# The third `map` initializes `n`. `n` will be `1,2,3,4`
# [ [[2, 3], [4, 5]], [6, 7]]
```

## Mutating Collections While Iterating

Do not mutate the collection that you're iterating through.

This is an example of bad:

```ruby
# The method remove_evens! should delete all even numbers from the array passed in as the argument.

def remove_evens!(arr)
  arr.each do |num|
    if num % 2 == 0
      arr.delete(num)
    end
  end
  arr
end

p remove_evens!([1,1,2,3,4,6,8,9])
# expected return value [1, 1, 3, 9]
# actual return value [1, 1, 3, 6, 9]
```

You get an unexpected return value because `delete` causes everything to shift left 1 position. So when we delete, it'll cause us to
Skip the next iteration essentially (because what was supposed to be next shifted to a place that we already past in our iteration)

We could fix this with a shallow copy. Iterate through the shallow copy while mutating the main copy:

```ruby
def remove_evens!(arr)
  cloned_arr = arr.dup
  cloned_arr.each do |num|
    if num % 2 == 0
      arr.delete(num)
    end
  end
  arr
end
```

This way, you're deleting from a different object, and so the object you're iterating over never shifts.

# Lesson 2 Summary

Know how to reference items within nested collections in order to manipulate them.

When you make a copy of a collection, it's a _shallow_ copy. That means the objects within the collection are shared.

Blocks and nested collections:

- Understand the structure
- Choose appropriate method and understand implementation and return value
- Understand what is being returned at each level. Return value, side effects.
