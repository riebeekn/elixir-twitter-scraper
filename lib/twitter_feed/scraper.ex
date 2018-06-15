defmodule TwitterFeed.Scraper do
  @moduledoc false

  @twitter_api Application.get_env(:twitter_feed, :twitter_api)

  alias TwitterFeed.Parser

  def scrape(handle, 0) do
    case @twitter_api.get_home_page(handle) do
      {:ok, %{status_code: 200, body: body}} ->
        body
        |> Parser.parse_tweets(:html)
      {:ok, %{status_code: 404}} ->
        return_404()
    end
  end

  def scrape(handle, start_after_tweet) do
    case @twitter_api.get_tweets(handle, start_after_tweet) do
      {:ok, %{status_code: 200, body: body}} ->
        body
        |> Parser.parse_tweets(:json)
      {:ok, %{status_code: 404}} ->
        return_404()
    end
  end

  defp return_404 do
    {:error, "404 error, that handle does not exist"}
  end
end
