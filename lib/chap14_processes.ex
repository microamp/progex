####################################################################################################
# a simple process
####################################################################################################

defmodule SpawnBasic do
  def greet do
    IO.puts "hello"
  end
end

# run it in the *same* process
SpawnBasic.greet

# run it in a *separate* process
pid = spawn SpawnBasic, :greet, []
IO.puts "new process:"
IO.inspect pid

####################################################################################################
# sending messages between processes
####################################################################################################

defmodule Spawn1 do
  def greet do
    receive do
      {sender, msg} ->
        send sender, {:ok, "hello, #{msg}"}
    end
  end
end

IO.puts "local process:"
IO.inspect self

pid = spawn Spawn1, :greet, []
IO.puts "new process:"
IO.inspect pid
send pid, {self, "world"}
receive do
  {:ok, message} ->
    IO.puts message
end

####################################################################################################
# handling multiple messages
####################################################################################################

defmodule Spawn2 do
  def greet do
    receive do
      {sender, msg} ->
        send sender, {:ok, "hello, #{msg}"}
    end
  end
end

pid = spawn Spawn2, :greet, []
IO.puts "new process:"
IO.inspect pid

# first message
send pid, {self, "james"}
receive do
  {:ok, msg} ->
    IO.puts msg
  after 500 ->
    IO.puts "the greeter did not respond in 500ms!!!"
end

# second message (wait for 500ms, then "the greeter has gone away!")
send pid, {self, "james"}
receive do
  {:ok, msg} ->
    IO.puts msg
  after 500 ->
    IO.puts "the greeter has gone away"
end

defmodule Spawn3 do
  def greet do
    receive do
      {sender, msg} ->
        send sender, {:ok, "hello, #{msg}"}
    end
    greet # recursion to receive next message
  end
end

pid = spawn Spawn3, :greet, []
IO.puts "new process:"
IO.inspect pid

send pid, {self, "world"}

# first message
receive do
  {:ok, msg} ->
    IO.puts "message: #{msg}"
end

# second message
send pid, {self, "stacey"}
receive do
  {:ok, msg} ->
    IO.puts "message: #{msg}"
end

####################################################################################################
# process overhead
####################################################################################################

defmodule Chain do
  def counter(next_pid) do
    receive do
      {:ok, count} ->
        send next_pid, {:ok, count + 1}
    end
  end

  def create_processes(n) do
    last_pid = Enum.reduce(
      1..n,
      self,
      fn _, next_pid -> spawn Chain, :counter, [next_pid] end
    )

    IO.puts "last pid:"
    IO.inspect last_pid

    send last_pid, {:ok, 0}

    receive do
      {:ok, count} ->
        IO.puts "final count: #{count}"
    end
  end

  def run(n) do
    # Chain.create_processes n
    IO.puts inspect :timer.tc(Chain, :create_processes, [n])
  end
end

Chain.run 100000

# from command-line:
# 1. elixir -r lib/chap14_processes.ex -e "Chain.run(100000)"
# 2. elixir --erl "+P 1000000" -r lib/chap14_processes.ex -e "Chain.run(1000000)"
# output:
# final count: 1000000
# {3124595, :ok}
# (~3 seconds to spawn one million processes on the *same* VM!!!)

####################################################################################################
# Exercise: WorkingWithMultipleProcesses-2
# Write a program that spawns two processes and then passes each a unique token (for
# example, "fred" and "betty"). Have them send the tokens back.
# * Is the order in which the replies are received deterministic in theory? In practice?
# * If either answer is no, how could you make it so?
####################################################################################################

defmodule Sync do
  def reply do
    receive do
      {sender, token} ->
        send sender, {:ok, token}
    end
  end

  def run do
    pid1 = spawn Sync, :reply, []
    pid2 = spawn Sync, :reply, []

    send pid2, {self, "betty"}
    send pid1, {self, "fred"}

    receive do
      {:ok, "fred"} ->
        IO.puts "fred received before"
    end

    receive do
      {:ok, "betty"} ->
        IO.puts "betty"
    end
  end
end

Sync.run
