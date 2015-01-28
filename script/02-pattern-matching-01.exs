# Exercise: PatternMatching-1
# Which of the following will match?

a = [1, 2, 3]  # [1, 2, 3]
a = 4  # 4
4 = a  # 4

# below would fail (** (MatchError) no match of right hand side value: [1, 2, 3])
# [a, b] = [1, 2, 3]

a = [[1, 2, 3]]  # [[1, 2, 3]]
[a] = [[1, 2, 3]]  # [[1, 2, 3]]

# below would fail (** (MatchError) no match of right hand side value: [[1, 2, 3]])
# [[a]] = [[1, 2, 3]]
