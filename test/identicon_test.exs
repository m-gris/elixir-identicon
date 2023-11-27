defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "hash_input is deterministic" do
    input = "Hello"
    first_hash = Identicon.hash_input(input) 
    second_hash =  Identicon.hash_input(input)
    assert first_hash == second_hash
  end

end
