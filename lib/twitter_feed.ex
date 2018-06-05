defmodule TwitterFeed do

  defdelegate get_tweets(handle, start_after_tweet \\ 0),
      to: TwitterFeed.Scraper, as: :scrape

end
