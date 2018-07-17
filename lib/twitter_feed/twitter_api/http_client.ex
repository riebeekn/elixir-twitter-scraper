defmodule TwitterFeed.TwitterApi.HttpClient do
  @moduledoc false

  @behaviour TwitterFeed.TwitterApi.Api

  alias TwitterFeed.TwitterApi.UrlBuilder

  def get_home_page(handle) do
    UrlBuilder.build_html_url(handle)
    |> HTTPoison.get(get_headers())
  end

  def get_tweets(handle, last_tweet_retrieved) do
    UrlBuilder.build_json_url(handle, last_tweet_retrieved)
    |> HTTPoison.get(get_headers())
  end

  defp get_headers do
    [
      {
        "user-agent",
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36"
      }
    ]
  end
end
