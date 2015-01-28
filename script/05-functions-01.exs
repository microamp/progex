# Exercise: Functions-1
# Go into iex. Create and run the functions that do the following:
# list_concat.([:a, :b], [:c, :d]) #=> [:a, :b, :c, :d]
# sum.(1, 2, 3) #=> 6
# pair_tuple_to_list.({1234, 5678}) #=> [1234, 5678]

list_concat = fn [item11, item12], [item21, item22] -> [item11, item12, item21, item22] end
[:a, :b, :c, :d] = list_concat.([:a, :b], [:c, :d])

sum = fn num1, num2, num3 -> num1 + num2 + num3 end
6 = sum.(1, 2, 3)

pair_tuple_to_list = fn {item1, item2} -> [item1, item2] end
[1234, 5678] = pair_tuple_to_list.({1234, 5678})
