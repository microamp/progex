# Exercise: PatternMatching-2
# Which of the following will match?

# below would fail (** (MatchError) no match of right hand side value: [1, 2, 3])
# [a, b, a] = [1, 2, 3]

# below would fail (** (MatchError) no match of right hand side value: [1, 1, 2])
# [a, b, a] = [1, 1, 2]

[a, b, a] = [1, 2, 1]  # [1, 2, 1]
