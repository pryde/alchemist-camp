defmodule FibonacciTest do
  use ExUnit.Case
  doctest Fibonacci

  test "4th fibonacci is 3" do
    assert Fibonacci.tail_fib_n(4) == 3
  end

  test "-1 fibonacci is bork" do
    assert Fibonacci.tail_fib_n(-1) == -1
  end
end
