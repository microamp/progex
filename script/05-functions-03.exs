# Exercise: Functions-3
# The operator rem(a, b) returns the remainder after dividing a by b. Write a function that takes a single integer (n) and calls the functions in the previous exercise, passing it rem(n, 3), rem(n, 5) and n. Call it seven times with the arguments 10, 11, 12, and so on. You should get "Buzz, 11, Fizz, 13, 14, FizzBuzz, 16"
# (Yes, it's a FizzBuzz solution with no conditional logic.)

fizz_buzz = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, third ->  third
end

func = fn n -> fizz_buzz.(rem(n, 3), rem(n, 5), n) end

"Buzz" = func.(10)
11 = func.(11)
"Fizz" = func.(12)
13 = func.(13)
14 = func.(14)
"FizzBuzz" = func.(15)
16 = func.(16)
