# produce = {
#   'apple' => 'Fruit',
#   'carrot' => 'Vegetable',
#   'pear' => 'Fruit',
#   'broccoli' => 'Vegetable'
# }

# def select_fruit(hash)
#   fruit_hash = {}
#   array = hash.to_a
#   counter = 0
#   loop do
#     if array[counter].include?("Fruit")
#       fruit_hash[array[counter][0]] = array[counter][1]
#     end
#     counter += 1
#     break if counter == array.length
#   end
#   fruit_hash
# end

# def select_fruit(hash)
#   hash.select.with_object({}) do |key_val_array, fruit_hash|
#     if key_val_array[1] == 'Fruit'
#       fruit_hash[key_val_array[0]] = key_val_array[1]
#     end
#   end    
# end

# p select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}

# def double_numbers(numbers)
#   doubled_numbers = []
#   counter = 0

#   loop do
#     break if counter == numbers.size

#     current_number = numbers[counter]
#     doubled_numbers << current_number * 2

#     counter += 1
#   end

#   doubled_numbers
# end

# def double_numbers!(numbers)
#   counter = 0
#   loop do
#     break if counter == numbers.length
#     current_number = numbers[0]
#     numbers << current_number * 2
#     numbers.shift
#     counter += 1
#   end
#   p numbers
# end

# my_numbers = [1, 4, 3, 7, 2, 6]
# double_numbers!(my_numbers)

# def double_odd_numbers(numbers)
#   doubled_numbers = []
#   counter = 0

#   loop do
#     break if counter == numbers.size

#     current_number = numbers[counter]
#     current_number *= 2 if counter.odd?
#     doubled_numbers << current_number

#     counter += 1
#   end

#   doubled_numbers
# # end

# def multiply(my_numbers, multiply_by)
#   numbers = []
#   counter = 0

#   loop do
#     break if counter == my_numbers.size

#     current_number = my_numbers[counter]
#     numbers << current_number * multiply_by

#     counter += 1
#   end

#   numbers
# end

# my_numbers = [1, 4, 3, 7, 2, 6]
# p multiply(my_numbers, 3)

# hash = {a:1,b:2,c:3}
# counter = 0
# hash_keys = hash.keys
# new_hash = {}
# loop do 
#   current_key = hash_keys[counter]
#   new_hash[current_key] = hash[current_key]
#   counter += 1
#   break if counter == hash_keys.size
# end
# new_hash

# Advanced PEDAC

# def star_method(stars)
#   arr = []
#   counter = 0

#   until counter == stars.size do
#     arr << stars[counter][0, 3]

#     counter += 1
#   end
#   arr
# end

# stars_1 = ['Sirius', 'Rigel', 'Vega', 'Polaris', 'Altair']
# p stars_2 = star_method(stars_1)
mailing_campaign_leads = [
  {name: 'Emma Lopez', email: 'emma.lopez@some_mail.com', days_since_login: 423, mailing_list: true},
  {name: 'mike richards', email: 'michael.richards@some_mail.com', days_since_login: 23, mailing_list: false},
  {name: 'JANE WILLIAMS', email: 'jane_w95@my_mail.com', days_since_login: 16, mailing_list: true},
  {name: 'Ash Patel', email: 'ash_patel@my_mail.com', days_since_login: 22, mailing_list: true}
]

counter = 0

loop do
  break if counter == mailing_campaign_leads.size
  full_name = mailing_campaign_leads[counter][:name]
  names = full_name.split

  names_counter = 0
  loop do
    break if names_counter == names.size
    name = names[names_counter]
    names[names_counter] = name.capitalize

    names_counter += 1
  end

  capitalized_full_name = names.join(' ')
  mailing_campaign_leads[counter][:name] = capitalized_full_name

  counter += 1
end

usable_leads = []
counter = 0

loop do
  break if counter == mailing_campaign_leads.size
  last_login = mailing_campaign_leads[counter][:days_since_login]
  subscribed_to_list = mailing_campaign_leads[counter][:mailing_list]

  if last_login < 60 && subscribed_to_list
    usable_leads << mailing_campaign_leads[counter]
  end

  counter += 1
end

mailing_campaign_leads.each do |lead|
  names = lead[:name].split
  lead[:name] = names.map { |name| name.capitalize }.join(' ')
end

# usable_leads = mailing_campaign_leads.reject do |lead|
#   last_login = lead[:days_since_login]
#   subscribed_to_list = lead[:mailing_list]
#   last_login > 59 || !subscribed_to_list
#   # reject returns falsey vals
#   # last_login was over 59 days ago and not subbed to list 
#   # if both of these are true, the whole statement is true, so not included in return
#   # using || instead of && fixes this issue because it says if either are true, don't include the whole element in return
#   # which is the same as saying if both of these opposite statements are true, include them
# end

p usable_leads

# mailing_campaign_leads.each do |lead|
#   names = lead[:name].split
#   names.map! { |name| name.capitalize }
#   lead[:name] = names.join(' ')
# end

# usable_leads = mailing_campaign_leads.select do |lead|
#   lead[:days_since_login] < 60 && lead[:mailing_list]
# end

# p usable_leads



