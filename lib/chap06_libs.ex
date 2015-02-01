# Exercise: ModulesAndFunctions-7
# Find the library functions to do the following, and then use each in iex. (If the word Elixir or Erlang appears at the end of the challenge, then you'll find the answer in that set of libraries.)

defmodule ExtLibs do
  # * Convert a float to a string with two decimal digits. (Erlang)
  def float_to_string(v, dec \\ 2) do
    hd :io_lib.format("~.#{dec}f", [v])
  end

  # * Get the value of an operating-system environment variable. (Elixir)
  def os_env(var) do
    System.get_env(var)
  end

  # * Return the extension component of a file name (so return .exs if given "dave/test.exs"). (Elixir)
  def file_extension(s) do
    s
    |> String.split(".")
    |> List.last
  end

  # * Return the process's current working directory. (Elixir)
  def cwd() do
    System.cwd()
  end

  # * Convert a string containing JSON into Elixir data structures. (Just find; don't install.)
  def load_json(json_str) do
    :ok  # there are many 3rd party libs, but there's none in stdlib
  end

  # * Execute a command in your operating system's shell.
  def shell(command, args \\ []) do
    System.cmd(command, args)
  end
end

# pattern matching tests
'1.23' = ExtLibs.float_to_string(1.234567890)
'3.14' = ExtLibs.float_to_string(:math.pi)

IO.puts "$HOME: #{ExtLibs.os_env("HOME")}"

"txt" = ExtLibs.file_extension("hello.world.txt")

IO.puts "pwd: #{ExtLibs.cwd()}"

{result, _} = ExtLibs.shell("ls", ["-l", "-a"])
IO.puts result
