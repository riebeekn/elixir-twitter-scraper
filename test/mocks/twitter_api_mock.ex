defmodule TwitterFeed.Mocks.TwitterApiMock do
  @behaviour TwitterFeed.TwitterApi.Api

  def get_home_page(:non_existant_handle) do
    {:ok, %{status_code: 404}}
  end

  def get_home_page(_handle) do
    body =
      Path.expand("#{File.cwd!}/test/data/twitter.html")
      |> File.read!

    {:ok, %{status_code: 200, body: body}}
  end
end
