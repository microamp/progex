# Exercise: Functions-5
# Use the &... notation to rewrite the following.
# * Enum.map [1, 2, 3, 4], fn x -> x + 2 end
# * Enum.each [1, 2, 3, 4], fn x -> IO.inspect x end

[3, 4, 5, 6] = Enum.map [1, 2, 3, 4], &(&1 + 2)

:ok = Enum.each [1, 2, 3, 4], &(IO.inspect &1)  # print 1, 2, 3, 4 in each line
