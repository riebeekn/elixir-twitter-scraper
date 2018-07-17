defmodule TwitterFeed.Scraper do
  @moduledoc false

  @twitter_api Application.get_env(:twitter_feed, :twitter_api)

  alias TwitterFeed.Parser

  def scrape(_handle, start_after_tweet) when start_after_tweet < 0 do
    {:error, "invalid start_after_tweet argument, can't be < 0"}
  end

  def scrape(handle, 0) do
    case @twitter_api.get_home_page(handle) do
      {:ok, %{status_code: 200, body: body}} ->
        body
        |> Parser.parse_tweets(:html)
      {:ok, %{status_code: 302, headers: headers}} ->
        headers
        |> return_302()
      {:ok, %{status_code: 404}} ->
        return_404()
    end
  end

  def scrape(handle, start_after_tweet) when start_after_tweet > 0 do
    case @twitter_api.get_tweets(handle, start_after_tweet) do
      {:ok, %{status_code: 200, body: body}} ->
        body
        |> Parser.parse_tweets(:json)
      {:ok, %{status_code: 302, headers: headers}} ->
        headers
        |> return_302()
      {:ok, %{status_code: 404}} ->
        return_404()
    end
  end

  defp return_302(headers) do
    header_map = Enum.into headers, %{}
    url = header_map["location"]
    {:redirect, "302 redirect received, redirect address: #{url}"}
  end

  defp return_404 do
    {:error, "404 error, that handle does not exist"}
  end
end
