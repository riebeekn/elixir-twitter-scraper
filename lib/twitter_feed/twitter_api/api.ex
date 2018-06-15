defmodule TwitterFeed.TwitterApi.Api do
  @moduledoc false

  @callback get_home_page(handle :: String.t) :: String.t
  @callback get_tweets(handle :: String.t, last_tweet_retrieved :: Integer.t) :: String.t
end
