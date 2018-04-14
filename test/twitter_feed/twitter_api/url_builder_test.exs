defmodule TwitterFeed.TwitterApi.UrlBuilderTest do
  use ExUnit.Case, async: true

  alias TwitterFeed.TwitterApi.UrlBuilder

  test "building the handle url" do
    url = UrlBuilder.build_html_url("my_handle")

    assert url == "https://twitter.com/my_handle"
  end

  test "building the json url" do
    expected_url = "https://twitter.com/i/profiles/show/my_handle/timeline/tweets?include_available_features=1&include_entities=1&max_position=4&reset_error_state=false"

    url = UrlBuilder.build_json_url("my_handle", 4)

    assert url == expected_url
  end
end
