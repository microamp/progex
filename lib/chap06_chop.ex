# Exercise: ModulesAndFunctions-6
# "I'm thinking of a number between 1 and 1000...."
# The most efficient way to find the number is to guess halfway between the low and high numbers of the range. If our guess is too big, then the answer lies between the bottom of the range and one less than our guess. If our guess is too small, then the answer lies between one more than our guess and the end of the range. Your API will be guess(actual, range), where range is an Elixir range.
# Your output should look similar to this:
# iex> Chop.guess(273, 1..1000)
# Is it 500
# Is it 250
# Is it 375
# Is it 312
# Is it 281
# Is it 265
# Is it 273
# 273

defmodule Chop do
  def guess(n, x.._, mid) when n < mid do
    guess n, x..mid
  end

  def guess(n, _..y, mid) when n > mid do
    guess n, mid..y
  end

  def guess(n, x..y, mid) do
    n
  end

  def guess(n, x..y) do
    mid = x + div(y - x, 2)
    IO.puts "Is it #{mid}"

    guess n, x..y, mid
  end
end

IO.puts Chop.guess(273, 1..1000)
