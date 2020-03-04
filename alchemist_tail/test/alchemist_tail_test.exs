defmodule AlchemistTailTest do
  use ExUnit.Case
  doctest AlchemistTail

  test "greets the world" do
    assert AlchemistTail.hello() == :world
  end
end
