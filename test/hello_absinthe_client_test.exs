defmodule HelloAbsintheClientTest do
  use ExUnit.Case
  doctest HelloAbsintheClient

  test "greets the world" do
    assert HelloAbsintheClient.hello() == :world
  end
end
