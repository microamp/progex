defmodule MyMap do
  def map([], _f), do: []
  def map([h | t], f), do: [f.(h) | map(t, f)]
end

[2, 4, 6] = MyMap.map([1, 2, 3], &(&1 * 2))
[10, 20, 30] = MyMap.map([1, 2, 3], fn(x) -> x * 10 end)

defmodule MyReduce do
  def reduce([], acc, _f) do
    acc
  end

  def reduce([h | t], acc, f) do
    reduce t, f.(acc, h), f
  end
end

15 = MyReduce.reduce [1, 2, 3, 4, 5], 0, &(&1 + &2)
120 = MyReduce.reduce [1, 2, 3, 4, 5], 1, fn(x, y) -> x * y end

defmodule MyList do
  # Exercise: ListsAndRecursion-0
  # I defined our sum function to carry a partial total as a second parameter so I could illustrate how to use accumulators to build values. The sum function can also be written without an accumulator. Can you do it?

  # without accumulator (no TCO)
  def sum([]), do: 0
  def sum([h | t]), do: h + sum(t)

  # with accumlator (TCO)
  def sum_acc(nums), do: _sum_acc(nums, 0)
  defp _sum_acc([], acc), do: acc
  defp _sum_acc([h | t], acc), do: _sum_acc(t, acc + h)

  # Exercise: ListsAndRecursion-1
  # Write a mapsum function that takes a list and a function. It applies the function to each element of the list and then sums the result, so
  # iex> MyList.mapsum [1, 2, 3], &(&1 * & 2)
  # 14
  def mapsum(nums, f), do: _mapsum(nums, 0, f)
  defp _mapsum([], acc, _), do: acc
  defp _mapsum([h | t], acc, f), do: _mapsum(t, acc + f.(h), f)

  # Exercise: ListsAndRecursion-2
  # Write a max(list) that returns the elemnt with the maximum value in the list. (This is slightly trickier than it sounds.)
  def max(nums), do: _max(nums)
  def _max([h | t]), do: _max(t, h)
  def _max([], current), do: current
  def _max([h | t], current) when h > current, do: _max(t, h)
  def _max([_h | t], current), do: _max(t, current)

  # Exercise: ListsAndRecursion-3
  # An Elixir single-quoted string is actually a list of individual character codes. Write a caesar(list, n) function that adds n to each list element, wrapping if the addition results in a character greater than z.
  # iex> MyList.caesar('ryvkve', 13)
  # ?????? :)
  def caesar([], _n), do: []

  def caesar([h | t], n) when h + n > ?z do
    [h + n - String.length("abcdefghijklmnopqrstuvwxyz") | caesar(t, n)]
  end

  def caesar([h | t], n) do
    [h + n | caesar(t, n)]
  end

  # Exercise: ListsAndRecursion-4
  # Write a function MyList.span(from, to) that returns a list of the numbers from from up to to.
  def span(current, to) when current > to do
    []
  end

  def span(current, to) do
    [current | span(current + 1, to)]
  end

  # Exercise: ListsAndRecursion-5
  # Implement the following Enum functions using no library functions or list comprehensions: all?, each, filter, split, and take. You may need to use an if statement to implement filter. The Syntax for this is
  # if condition do
  #   expression(s)
  # else
  #   expression(s)
  # end

  # 5.1. all?
  def all?([], _pred), do: true

  def all?([h | t], pred) do
    if pred.(h) do
      all?(t, pred)
    else
      false
    end
  end

  # 5.2. each
  def each(coll, f) do
    for item <- coll, do: f.(item)
    :ok
  end

  # 5.3. filter
  def filter([], _f), do: []

  def filter([h | t], f) do
    if f.(h) do
      [h | filter(t, f)]
    else
      filter(t, f)
    end
  end

  # 5.4. split
  def split(coll, n) do
    _split([], coll, n, 0)
  end

  defp _split(left, [], _n, _cnt) do
    {Enum.reverse(left), []}
  end

  defp _split(left, [h | t], n, cnt) when cnt < n do
    _split([h | left], t, n, cnt + 1)
  end

  defp _split(left, right, _n, _cnt) do
    {Enum.reverse(left), right}
  end

  # 5.5. take
  def take(coll, n), do: _take(coll, n, 0)

  defp _take([], _n, _cnt), do: []

  defp _take([h | t], n, cnt) when cnt < n do
    [h | _take(t, n, cnt + 1)]
  end

  defp _take(_coll, _n, _cnt), do: []

  # Exercise: ListsAndRecursion-6
  # (Hard) Write a flatten(list) function that takes a list that may contain any number of sublists, which themselves may contain sublists, to any depth. It returns the elements of these lists as a flat list.
  # iex> MyList.flatten([1, [2, 3, [4]], 5, [[[6]]]])
  # [1, 2, 3, 4, 5, 6]
  # Hint: You may have to use Enum.reverse to get your result in the correct order.
  # TODO:

  # Exercise: ListsAndRecursion-7
  # In the last exercise of Chapter 7, Lists and Recursion, you wrote a span function. Use it and list comprehensions to return a list of the prime numbers from 2 to n.
  def prime(n) do
    for x <- span(2, n), _prime?(x), do: x
  end

  defp _prime?(n) when n == 2, do: true

  defp _prime?(n) do
    2..n - 1
    |> Enum.to_list
    |> Enum.filter(&(rem(n, &1) == 0))
    |> Enum.empty?
  end

  # Exercise: ListsAndRecursion-8
  # The Pragmatic Bookshelf has offices in Texas (TX) and North Carolina (NC), so we have to charge sales tax on orders shipped to these states. The rates can be expressed as a keyword list:
  # tax_rates = [NC: 0.075, TX: 0.08]
  # Here's a list of orders:
  # orders = [
  #   [id: 123, ship_to: :NC, net_amount: 100.00],
  #   [id: 124, ship_to: :OK, net_amount:  35.50],
  #   [id: 125, ship_to: :TX, net_amount:  24.00],
  #   [id: 126, ship_to: :TX, net_amount:  44.80],
  #   [id: 127, ship_to: :NC, net_amount:  25.00],
  #   [id: 128, ship_to: :MA, net_amount:  10.00],
  #   [id: 129, ship_to: :CA, net_amount: 102.00],
  #   [id: 120, ship_to: :NC, net_amount:  50.00],
  # ]
  # Write a function that takes both lists and returns a copy of the orders, but with an extra field, total_amount, which is the net plus sales tax. If a shipment is not to NC or TX, there's no tax applied.
  def total_amount(tax_rates, orders) do
    # TODO: find a better way than `Keyword.get keyword_list, key, default`
    for order <- orders, do:
    order ++ [total_amount: order[:net_amount] * (1.0 + Keyword.get(tax_rates, order[:ship_to], 0.0))
              |> Float.round(2)]
  end
end

# pattern matching tests
10 = MyList.sum([1, 2, 3, 4])
15 = MyList.sum_acc([1, 2, 3, 4, 5])

14 = MyList.mapsum [1, 2, 3], &(&1 * &1)

5 = MyList.max([1, 2, 3, 4, 5])
5 = MyList.max([5, 4, 3, 2, 1])
5 = MyList.max([3, 4, 5, 1, 2])

'elixir' = MyList.caesar('ryvkve', 13)

[1] = MyList.span(1, 1)
[1, 2, 3, 4, 5] = MyList.span(1, 5)
[100, 101, 102, 103] = MyList.span(100, 103)

even? = &(rem(&1, 2) == 0)

true = MyList.all?([2, 4, 6, 8], even?)
false = MyList.all?([1, 3, 5, 7], even?)
false = MyList.all?([2, 4, 6, 7], even?)

:ok = MyList.each ["some", "example"], fn(x) -> IO.puts x end

[2, 4, 6, 8, 10] = MyList.filter(Enum.to_list(1..10), even?)

IO.inspect MyList.split(Enum.to_list(1..10), 4)

[] = MyList.take([], 100)
[1, 2, 3, 4, 5] = MyList.take(Enum.to_list(1..10), 5)

{[], []} = MyList.split([], 100)
{[1], [2, 3]} = MyList.split([1, 2, 3], 1)
{[1, 2], [3]} = MyList.split([1, 2, 3], 2)
{[1, 2, 3], []} = MyList.split([1, 2, 3], 100)

[2, 3, 5, 7] = MyList.prime(10)

tax_rates = [NC: 0.075, TX: 0.08]
orders = [
  [id: 123, ship_to: :NC, net_amount: 100.00],
  [id: 124, ship_to: :OK, net_amount:  35.50],
  [id: 125, ship_to: :TX, net_amount:  24.00],
  [id: 126, ship_to: :TX, net_amount:  44.80],
  [id: 127, ship_to: :NC, net_amount:  25.00],
  [id: 128, ship_to: :MA, net_amount:  10.00],
  [id: 129, ship_to: :CA, net_amount: 102.00],
  [id: 120, ship_to: :NC, net_amount:  50.00],
]
[
  [id: 123, ship_to: :NC, net_amount: 100.00, total_amount: 107.5],
  [id: 124, ship_to: :OK, net_amount:  35.50, total_amount: 35.50],
  [id: 125, ship_to: :TX, net_amount:  24.00, total_amount: 25.92],
  [id: 126, ship_to: :TX, net_amount:  44.80, total_amount: 48.38],
  [id: 127, ship_to: :NC, net_amount:  25.00, total_amount: 26.88],
  [id: 128, ship_to: :MA, net_amount:  10.00, total_amount: 10.00],
  [id: 129, ship_to: :CA, net_amount: 102.00, total_amount: 102.00],
  [id: 120, ship_to: :NC, net_amount:  50.00, total_amount: 53.75],
] = MyList.total_amount(tax_rates, orders)
