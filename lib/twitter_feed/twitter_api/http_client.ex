defmodule TwitterFeed.TwitterApi.HttpClient do
  @moduledoc false

  @behaviour TwitterFeed.TwitterApi.Api

  alias TwitterFeed.TwitterApi.UrlBuilder

  def get_home_page(handle) do
    UrlBuilder.build_html_url(handle)
    |> HTTPoison.get()
  end
end
