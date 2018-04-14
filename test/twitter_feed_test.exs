defmodule TwitterFeedTest do
  use ExUnit.Case
  doctest TwitterFeed

  test "greets the world" do
    assert TwitterFeed.hello() == :world
  end
end
