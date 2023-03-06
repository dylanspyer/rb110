=begin
You have to create a method that takes a positive integer number and returns the next bigger number formed by the same digits. 
examples: 
12 --> 21 
513 --> 531
2017 --> 2071
If no bigger number can be formed using these digits, return -1. 
examples: 
9 --> -1
111 --> -1
531 --> -1 

=end

# INPUT: positive int 
# OUTPUT: int 
# RULES: 
# - return next biggest num w/ same digits 
# - if no bigger num, -1
# - always int input
# - single digit nums always -1
# - if num is already sorted largest to smallest, -1
# OVERVIEW: take a positive number rearrange the digits in that number such that we return the next largest number with the same digits
# ALGO:
# - initialize var number as a string
# - take num at last index (-1)
# - move it one index to the left (-2)
# - test if that new num is greater than input num
#   - if new num is greater than input, return new num
#   - if not,
#     - reassign last_index -= 1 (which also reassigns second_last_index)
#     - test if new num is greater than input, return new num if so
#     - repeat until second_last_index == the negative length of the string num
#   - return -1 if not


# def next_bigger(num)
#   return -1 if num.to_s.length < 2

#   string_num = num.to_s
  
#   start_last_index = -1
#   start_second_last_index = start_last_index - 1
#   poss_solutions = []

#   loop do
#     last_index = start_last_index
#     second_last_index = start_second_last_index
#     string_num = num.to_s
#     break if second_last_index <= -(num.to_s.size)
#     loop do
#       string_num[second_last_index], string_num[last_index] = string_num[last_index], string_num[second_last_index]
#         p string_num
#         if string_num.to_i > num
#           poss_solutions << string_num.to_i 
#         else
#           last_index = second_last_index
        
#           second_last_index -= 1
#         end

        
        
#         if second_last_index < -(num.to_s.size)
#           break if start_second_last_index <= -(num.to_s.size)
#           start_last_index -= 1
#           start_second_last_index -= 1

#           break
#         end
#     end

#   end
#   poss_solutions.min
#   # need to run this again, but with new second_last_index and last_index inputs
#   # both shifted left
#   # run on the original num
  
# end

# def helper(last_index, second_last_index)

# end

# p next_bigger(59884848459853) #== 414


# def next_bigger(num)
#   digits = num.digits.reverse
#   digits = digits.permutation(digits.size).to_a
#   digits.map!(&:join).map!(&:to_i).sort

#   larger_nums = digits.select { |int| int > num }

#   larger_nums.empty? ? -1 : larger_nums[0]
# end

# def next_bigger(num)
#   largest = num.digits.sort.reverse.join.to_i
  
#   ((num + 1)..largest).each do |result|
#     return result if result.digits.sort == num.digits.sort
#   end
  
#   -1
# end


# p next_bigger(9) == -1
# p next_bigger(12) == 21
# p next_bigger(513) == 531
# p next_bigger(2017) == 2071
# p next_bigger(111) == -1
# p next_bigger(531) == -1
# p next_bigger(123456789) == 123456798

# p next_bigger(11211) == 12111

=begin

Some numbers have funny properties. For example:

> 89 --> 8¹ + 9² = 89 * 1

> 695 --> 6² + 9³ + 5⁴= 1390 = 695 * 2

> 46288 --> 4³ + 6⁴+ 2⁵ + 8⁶ + 8⁷ = 2360688 = 46288 * 51

Given a positive integer n written as abcd... (a, b, c, d... being digits) and a positive integer p 

-   we want to find a positive integer k, if it exists, such that the sum of the digits of n taken to the successive powers of p is equal to k * n.

In other words:

> Is there an integer k such as : (a ^ p + b ^ (p+1) + c ^(p+2) + d ^ (p+3) + ...) = n * k

If it is the case we will return k, if not return -1.

**Note**: n and p will always be given as strictly positive integers.

dig_pow(89, 1) should return 1 since 8¹ + 9² = 89 = 89 * 1
dig_pow(92, 1) should return -1 since there is no k such as 9¹ + 2² equals 92 * k
dig_pow(695, 2) should return 2 since 6² + 9³ + 5⁴= 1390 = 695 * 2
dig_pow(46288, 3) should return 51 since 4³ + 6⁴+ 2⁵ + 8⁶ + 8⁷ = 2360688 = 46288 * 51

=end

=begin
---------------- Problem


Restate the problem:

Create a method that accepts an integer for an argument `n`, as well an a second integer `p`, and returns `k` which is the result of putting each digit with `n` to the successive power of `p`, summing it and dividing it by `n` to give us `k`. `k` should be a whole number, if not, return -1. 


Input: Integers (base, exponent)

Output: Integer (-1 or `k` if `k` is a whole number)




Explicit Rules:
- splitting `base` into digits and put to the successive power of `p`



Implicit Rules:
- `k` must be a whole number, if not, return -1


Modelling:

I: 89, 1
O: 1

8**1, 9**2 => sum the result => divide by `base` => if whole number => return `k` => if not return -1


---------------- Examples

p dig_pow(89, 1) == 1
p dig_pow(92, 1) == -1
p dig_pow(46288, 3) == 51
p dig_pow(695, 2) == 2

---------------- Data Structures

I: int
Itermediate: Array
O: Int


---------------- Scratchboard






---------------- Algorithm

/* given two integers `base` and `exponent` */

Initialize `current_num` to `exponent`

Split `base` into an array of digits and sort it to match the given number
  - Iterate through the collection and transform each element
    - Place each element to the successive power of `current_num`
    - Increment `current_num` by 1

Sum the resulting collection
  - Divide the sum by `base`
    - If the resulting number is a whole number, return the result
      - If not, return -1


=end

# def dig_pow(base, exp)
#   current_num = exp
#   digits = base.digits.reverse

#   digits.map! do |num|
#     num = num ** current_num
#     current_num += 1
#     num
#   end

#   sum = digits.sum

#   sum % base == 0 ? sum / base : -1
# end

# p dig_pow(89, 1) == 1
# p dig_pow(92, 1) == -1
# p dig_pow(46288, 3) == 51
# p dig_pow(695, 2) == 2


# def minimum_sum(arr)
#   arr_sums = []
#   arr.each.with_index do |num, idx|
#     arr_sums << arr[idx..(idx + 4)].sum if arr[idx..(idx + 4)].size >= 5
#   end
#   arr_sums.min
# end

# p minimum_sum([1, 2, 3, 4]) == nil
# p minimum_sum([1, 2, 3, 4, 5, 6]) == 15
# p minimum_sum([55, 2, 6, 5, 1, 2, 9, 3, 5, 100]) == 16
# p minimum_sum([-1, -5, -3, 0, -1, 2, -4]) == -10

=begin
You have to create a method that takes a positive integer number and returns the next bigger number formed by the same digits. 
examples: 
12 --> 21 
513 --> 531
2017 --> 2071
If no bigger number can be formed using these digits, return -1. 
examples: 
9 --> -1
111 --> -1
531 --> -1 
=end

# 
order_data = [
  {customer_id: 12, customer_name: 'Emma Lopez', order_id: 351, order_date: '12/04/16', order_fulfilled: true, order_value: 135.99},
  {customer_id: 12, customer_name: 'Emma Lopez', order_id: 383, order_date: '12/04/16', order_fulfilled: true, order_value: 289.49},
  {customer_id: 12, customer_name: 'Emma Lopez', order_id: 392, order_date: '01/10/17', order_fulfilled: false, order_value: 58.00},
  {customer_id: 32, customer_name: 'Michael Richards', order_id: 241, order_date: '11/10/16', order_fulfilled: true, order_value: 120.00},
  {customer_id: 32, customer_name: 'Michael Richards', order_id: 395, order_date: '01/10/17', order_fulfilled: false, order_value: 85.65},
  # rest of data...
]

customer_orders = [
  {
    customer_id: 12,
    customer_name: 'Emma Lopez',
    orders: [
      { order_fulfilled: true, order_value: 135.99 },
      { order_fulfilled: true, order_value: 289.49 },
      { order_fulfilled: false, order_value: 58.00 }
    ]
  },
  {
    customer_id: 32,
    customer_name: 'Michael Richards',
    orders: [
      { order_fulfilled: true, order_value: 120.00 },
      { order_fulfilled: false, order_value: 85.65 }
    ]
  },
  # rest of data...
]

customer_orders = order_data.map do |row|
  {
    customer_id: row[:customer_id],
    customer_name: row[:customer_name],
    orders: [
      {
        order_fulfilled: row[:order_fulfilled],
        order_value: row[:order_value]
      }
    ]
  }
end

p customer_orders


