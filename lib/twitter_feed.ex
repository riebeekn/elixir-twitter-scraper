defmodule TwitterFeed do

  defdelegate get_tweets(handle, pages_to_get \\ 1, start_after_tweet \\ 0),
      to: TwitterFeed.Scraper, as: :scrape

end
