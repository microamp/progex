# Exercise: Functions-2
# Write a function that takes three arguments. If the first two are zero, return "FizzBuzz". If the first is zero, return "Fizz." If the second is zero, return "Buzz". Otherwise return the third argument. Do not use any language features that we haven't yet covered in this book.

fizz_buzz = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, third ->  third
end

"FizzBuzz" = fizz_buzz.(0, 0, 1)
"Fizz" = fizz_buzz.(0, 1, 1)
"Buzz" = fizz_buzz.(1, 0, 1)
"hey" = fizz_buzz.(1, 1, "hey")
