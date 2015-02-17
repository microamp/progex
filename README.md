Progex
======

Programming Elixir (an extended version of Learn Elixir in Y Minutes)

```elixir
# This is a comment.

# ------------
# ** Basics **
# ------------

1 # integer
1.0 # float
:a # atom

1 == 1.0 # => true
1 === 1.0 # => false

"a" # string (double-quoted)
'hello' # => 'hello' is a char list (single-quoted)
'hełło' # => [104, 101, 322, 322, 111]

1..10 # range (both ends inclusive)

# ---------------------
# ** Data Structures **
# ---------------------

[1, 2, 3] # list (linked list)
{:hi, "hello", 10} # tuple

# keyword list (ordered keys, duplicate keys are allowed)
is_list [a: 1, b: 2, b: 200] # => true
[a: 1, b: 2, b: 200] # => [a: 1, b: 2, b: 200]
[a:1, b: 2][:a] # => 1

# map (unordered keys, no duplicate keys)
is_map %{a: 1, b: 2, b: 200} # => true
%{a: 1, b: 2, b: 200} # => %{a: 1, b: 200} (no duplicate keys)

# HashDict (like map, but works better with large data)
%{a: 1, b: 2} |> Enum.into HashDict.new # => #HashDict<[b: 2, a: 1]>

# ----------------------
# ** Pattern Matching **
# ----------------------
# Pattern matching is at the heart of Elixir, and works on most of the data structures.
# '=' is not an assignment in Elixir. It's the pattern matching operator.

# on tuple
{_, second, _} = {:a, :b, :c}
second # => :b

# on list
[head | tail] = [1, 2, 3]
head # => 1
tail # => [2, 3]

# on map
%{id: id, langs: langs} = %{id: "microamp", langs: ["py", "ex"]}
id # => "microamp"
langs # => ["py", "ex"]

# on ranges
lower..upper = 1..10
lower # => 1
upper # => 10

# -------------------------
# ** Anonymous Functions **
# -------------------------
# Functions are first-class citizens in Elixir.

# anonymous function
len = fn(s) -> String.length s end
len.("abcde") # => 5 (note the dot)

# anonymous function (with syntax sugar)
add = &(&1 + &2)
add.(1, 10) # => 11 (again, note the dot)

# ---------------
# ** Functions **
# ---------------
# Named functions can be organised inside a module.

defmodule Arithmetic do
  def add(a, b) do
    a + b
  end

  # b is optional, default value 2 is used unless specified
  def multiply(a, b \\ 2) do
    a * b
  end
end

Arithmetic.add(100, 200) # => 300 (format: Module.function)
Arithmetic.multiply(10) # => 20 (without optional arguments)

# ---------------
# ** Recursion **
# ---------------
# There are no imperative looping constructs like for/while-loops in Elixir.
# Together with pattern matching, recursive functions are a very powerful tool.
# Note to self: Recursion is cool, but do *not* overuse it. Use Enum/Stream
# when it's more appropriate to use them than recursion.

defmodule MyList do
  # base case
  def sum([]), do: 0

  # inductive case
  def sum([h | t]) do
    h + sum(t)
  end
end

MyList.sum([1, 2, 3, 4]) # => 10

# The above example can be easily changed to one that uses a tail-call.
# Hint: Use an additional argument as an accumulator.

# ------------
# ** Struct **
# ------------
# Useful to define a behaviour. Note to self: Do *not* use structs like
# how you would define classes in OO. Can be easily abused if not careful
# especially coming from an OO background.

defmodule Person do
  defstruct first_name: "", last_name: "", age: 0

  # add more behaviour-specific functions here...
end

%Person{} # => %Person{age: 0, first_name: "", last_name: ""}
%Person{first_name: "jimbo", age: 100} # => %Person{age: 100, first_name: "jimbo", last_name: ""}

# ----------------
# ** Directives **
# ----------------
# TODO: import/alias/require

# -------------------
# ** Control Flows **
# -------------------

# single-line if-else expression
x = 8
if rem(x, 2) == 0, do: "#{x} is even", else: "#{x} is odd" # => "8 is even"

# cond
x = 9
cond do
  rem(x, 2) == 0 -> "#{x} is even"
  true -> "#{x} is odd"
end # => "9 is odd"

# case
case x do
  0 -> "zero!"
  2 -> "two!"
  _ -> "something else!" # '_' matches all
end # => "something else!"

# ---------------------
# ** Enum and Stream **
# ---------------------
# TODO: more examples

# double each element in the list
Enum.map([1, 2, 3, 4, 5], &(&1 * 2)) # => [2, 4, 6, 8, 10]

# filter out odd numbers from the list
Enum.filter([1, 2, 3, 4, 5], fn(x) -> rem(x, 2) == 0 end) # => [2, 4]

# sum all elements in the list
Enum.reduce([1, 2, 3, 4], &(&1 + &2)) # => 10

# -------------------
# ** Comprehension **
# -------------------
# Fun little syntax sugar. Combines map and filter in the same construct.
# Note to self: Think of the Python list comprehension.

for x <- 1..10, rem(x, 2) == 0, do: x * 2 # => [4, 8, 12, 16, 20]

# -------------------
# ** Pipe Operator **
# -------------------
# One of the cool features of Elixir that's missing in Erlang.

# same as Enum.map(Enum.filter(1..10, &(rem(&1, 2) == 0)), &(&1 * 2)) (arguably harder to read)
1..10
|> Enum.filter(&(rem(&1, 2) == 0))
|> Enum.map(&(&1 * 2)) # => [4, 8, 12, 16, 20]

# --------------------
# ** Erlang Interop **
# --------------------
# Elixir is fully compatible with Erlang/BEAM/OTP.

:math.pi() # => 3.141592653589793 (note: preceded by colon, ':')

# ----------------------------------
# ** Concurrency with Actor Model **
# ----------------------------------
defmodule HelloWorld do
  def greet do
    receive do
      {sender, name} ->
        send sender, {:ok, "hello #{name}"}
    end
  end
end

# current process
IO.puts "current process:"
IO.inspect self # => e.g. #PID<0.49.0>

# spanwed process
pid = spawn HelloWorld, :greet, []
IO.puts "spawned process:"
IO.inspect pid # => e.g. #PID<0.55.0>

# send message to spawned processes
send pid, {self, "world"}

# receive message from spawned process
receive do
  {:ok, msg} ->
    IO.puts "message received: #{msg}" # => "message received: hello world"
end
```
