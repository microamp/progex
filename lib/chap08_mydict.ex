# 1. keyword list
[a: 1, b: 2, c: 3, b: 4]  # duplicate key, :b

# 2. map
m = %{a: 1, b: 2, c: 3}
# below would raise compilation error
# %{1: :a, 2: :b, 3: :c}
# do this instead
%{1 => :a, 2 => :b, 3 => :c}

# update
%{c: new_value} = %{m | c: 300}  # pattern matching
300 = new_value

# 3. HashDict
hdict = %{a: 1, b: 2, c: 3} |> Enum.into HashDict.new  # Dict => HashDict
true = is_map hdict  # is still a map

# 4. struct
defmodule Subscriber do
  @derive Access  # allowing s[:name] as well as dot notation
  defstruct name: "", paid: false, over_18: true

  # add more struct-specific behaviour here...
end

# from iex
# 4.1. instantiation
# iex(177)> s = %Subscriber{name: "tyson"}
# %Subscriber{name: "tyson", over_18: true, paid: false}
# 4.2. update (no modification of existing data structure)
# iex(178)> s2 = %Subscriber{s | name: "jimbo"}
# %Subscriber{name: "jimbo", over_18: true, paid: false}
# 4.3.1. access via dot notation
# iex(179)> "jimbo" = s2.name
# "jimbo"
# 4.3.2. access via [:key]
# iex(184)> "jimbo" = s2[:name]
# "jimbo"

defmodule Outer do
  defstruct name: "", inner: %{}
end

defmodule Inner do
  defstruct name: "", age: 0
end

# 4.1. nested structs
# iex(188)> o = %Outer{name: "family", inner: %Inner{name: "me"}}
# %Outer{inner: %Inner{age: 0, name: "me"}, name: "family"}
# 4.2. access via dot notations
# iex(189)> o.inner.age
# 0
# 4.3. the 'put_in' macro! (see also, 'get_in', 'update_in', 'get_and_update_in', etc.)
# iex(190)> put_in(o.inner.age, 100)
# %Outer{inner: %Inner{age: 100, name: "me"}, name: "family"}

# 5. sets (unordered, no duplicate items)
# e.g.
# iex(192)> 1..10 |> Enum.into HashSet.new
# #HashSet<[7, 2, 6, 3, 4, 1, 5, 9, 10, 8]>
# 5.1. 'difference' and 'intersection'
# iex(193)> set1 = 1..5 |> Enum.into HashSet.new
# #HashSet<[2, 3, 4, 1, 5]>
# iex(194)> set2 = 3..7 |> Enum.into HashSet.new
# #HashSet<[7, 6, 3, 4, 5]>
# iex(195)> HashSet.difference set1, set2
# #HashSet<[2, 1]>
# iex(196)> HashSet.intersection set1, set2
# #HashSet<[3, 4, 5]>
