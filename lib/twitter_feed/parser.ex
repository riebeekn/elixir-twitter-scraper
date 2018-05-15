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
    user_id = parse_user_id(tweet_html)
    is_retweet = parse_is_retweet(tweet_html)

    %Tweet {
      handle_id: parse_handle_id(is_retweet, user_id, tweet_html),
      user_id: user_id,
      user_name: parse_user_name(tweet_html),
      display_name: parse_display_name(tweet_html),
      tweet_id: parse_tweet_id(tweet_html),
      timestamp: parse_timestamp(tweet_html),
      text_summary: parse_text(tweet_html) |> truncate(),
      image_url: parse_image(tweet_html),
      retweet: is_retweet
    }
  end

  use Publicist
  defp parse_display_name(tweet_html) do
    tweet_html
    |> Floki.attribute("data-name")
    |> hd()
  end

  defp parse_user_id(tweet_html) do
    tweet_html
    |> Floki.attribute("data-user-id")
    |> hd()
    |> String.to_integer()
  end

  defp parse_user_name(tweet_html) do
    tweet_html
    |> Floki.attribute("data-screen-name")
    |> hd()
  end

  defp parse_tweet_id(tweet_html) do
    tweet_html
    |> Floki.attribute("data-tweet-id")
    |> hd()
    |> String.to_integer()
  end

  defp parse_timestamp(tweet_html) do
    tweet_html
    |> Floki.find("._timestamp")
    |> Floki.attribute("data-time-ms")
    |> hd()
    |> String.to_integer()
    |> DateTime.from_unix!(:millisecond)
    |> DateTime.to_string()
  end

  defp parse_text(tweet_html) do
    tweet_html
    |> Floki.find(".tweet-text")
    |> Floki.text()
    |> String.trim()
  end

  defp parse_image(tweet_html) do
    tweet_html
    |> Floki.find(".AdaptiveMedia-photoContainer")
    |> Floki.attribute("data-image-url")
    |> Floki.text()
  end

  defp parse_is_retweet(tweet_html) do
    tweet_html
    |> Floki.attribute("data-retweeter")
    |> Enum.count() == 1
  end

  defp parse_handle_id(false, user_id, _tweet_html) do
    user_id
  end

  defp parse_handle_id(true, _user_id, tweet_html) do
    tweet_html
    |> Floki.find(".js-retweet-text > a")
    |> Floki.attribute("data-user-id")
    |> hd()
    |> String.to_integer()
  end

  defp truncate(text) do
    if (String.length(text)) > 30 do
      String.slice(text, 0, 30) <> "..."
    else
      text
    end
  end
end
