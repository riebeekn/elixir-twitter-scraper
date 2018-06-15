defmodule TwitterFeed.Mocks.TwitterApiMock do
  @behaviour TwitterFeed.TwitterApi.Api

  def get_home_page(:non_existant_handle) do
    {:ok, %{status_code: 404}}
  end

  def get_home_page(_handle) do
    load_from_file("html")
  end

  def get_tweets(_handle, _last_tweet_retrieved) do
    load_from_file("json")
  end

  defp load_from_file(extension) do
    body =
      Path.expand("#{File.cwd!}/test/data/twitter.#{extension}")
      |> File.read!

    {:ok, %{status_code: 200, body: body}}
  end
end
