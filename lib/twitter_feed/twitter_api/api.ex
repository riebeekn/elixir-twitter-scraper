defmodule TwitterFeed.TwitterApi.Api do
  @moduledoc false

  @callback get_home_page(handle :: String.t) :: String.t
end
