defmodule TwitterFeed.Mocks.TwitterApiMock do
  @behaviour TwitterFeed.TwitterApi.Api

  def get_home_page(:non_existant_handle) do
    {:ok, %{status_code: 404}}
  end

  def get_home_page(_handle) do
    {:ok, %{status_code: 200, body: "This handle looks good!"}}
  end
end
