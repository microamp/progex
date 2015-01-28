# Exercise: ModulesAndFunctions-1
# Extend the Times module with a triple function that multiplies its parameter by three.
# Exercise: ModulesAndFunctions-2
# Run the result in iex. Use both techniques to compile the file.
# Exercise: ModulesAndFunctions-3
# Add a quadruple function (Maybe it could call the double function....)

defmodule Times do
  def double(n), do: n * 2

  def triple(n), do: n * 3

  def quadruple(n), do: double(n) * 2
end

# pattern matching tests
30 = Times.triple(10)
40 = Times.quadruple(10)
