defmodule TwitterFeed.Parser do
  @moduledoc false

  alias TwitterFeed.Tweet

  def parse_tweets(html) do
    tweet_html =
      html
      |> Floki.find(".tweet")

    Enum.map(tweet_html, fn(x) -> parse_tweet(x) end)
  end

  ##################### PRIVATE FUNCTIONS #####################
  defp parse_tweet(tweet_html) do
    %Tweet {
      display_name: parse_display_name(tweet_html)
    }
  end

  use Publicist
  defp parse_display_name(tweet_html) do
    tweet_html
    |> Floki.attribute("data-name")
    |> hd()
  end
end
