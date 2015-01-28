# Exercise: Functions-4
# Write a function prefix that takes a string. It should return a new function that takes a second string. When that second function is called, it will return a string containing the first string, a space, and the second string.

prefix = fn s1 -> (fn s2 -> "#{s1} #{s2}" end) end

"hello world!" = prefix.("hello").("world!")

mrs = prefix.("Mrs")
"Mrs Smith" = mrs.("Smith")

"Elixir Rocks" = prefix.("Elixir").("Rocks")
