# Exercise: PatternMatching-3
# If you assume the variable a initially contains the value 2, which of the following will match?

# assume 'a' is initially value 2
a = 2

# below would fail (** (MatchError) no match of right hand side value: [1, 2, 3])
# [a, b, a] = [1, 2, 3]

# below would fail (** (MatchError) no match of right hand side value: [1, 1, 2])
# [a, b, a] = [1, 1, 2]

a = 1  # 1

# below would fail (** (MatchError) no match of right hand side value: 2)
# ^a = 2

^a = 1  # 1

^a = 2 - a  # 1
