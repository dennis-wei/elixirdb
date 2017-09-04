defmodule ElixirdbTest do
  use ExUnit.Case
  doctest Elixirdb

  test "greets the world" do
    assert Elixirdb.hello() == :world
  end
end
