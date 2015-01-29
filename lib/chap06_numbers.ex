defmodule Numbers do
  # Exercise: ModulesAndFunctions-4
  # Implement and run a function sum(n) that uses recursion to calculate the sum of the integers rom 1 to n. You'll need to write this function inside a module in a separate file. then load up iex, compile that file, and try your function.
  def sum(0), do: 0
  def sum(n), do: n + sum(n - 1)

  # Exercise: ModulesAndFunctions-5
  # Write a function gcd(x, y) that finds the greatest common divisor between two nonnegative integers. Algebraically, gcd(x, y) is x if y is zero; it's gcd(y, rem(x, y)) otherwise.
  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))
end

# pattern matching tests
1 + 2 + 3 + 4 + 5 = Numbers.sum(5)
6 = Numbers.gcd(12, 18)
