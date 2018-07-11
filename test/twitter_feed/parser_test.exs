defmodule TwitterFeed.ParserTest do
  use ExUnit.Case, async: true

  alias TwitterFeed.Parser

  test "parsing of min position from json response" do
    assert Parser.parse_json_min_position("33") == 33
  end

  test "parsing of min position from json response should return 0 when the page has no tweets" do
    assert Parser.parse_json_min_position(nil) == 0
  end

  test "parsing of has more items when there are no more items" do
    html_snippet = "<div class=\"timeline-end has-items \">"

    assert Parser.parse_html_has_more_items(html_snippet) == false
  end

  test "parsing of has more items when there are more items" do
    html_snippet = "<div class=\"timeline-end has-items has-more-items\">"

    assert Parser.parse_html_has_more_items(html_snippet) == true
  end

  test "parsing of min position from html response" do
    html_snippet = "<div class=\"stream-container\" data-min-position=\"33\">"

    assert Parser.parse_html_min_position(html_snippet) == 33
  end

  test "parsing of min position from html response should return 0 when the page has no tweets" do
    html_snippet = "<div class=\"stream-container\" data-min-position=\"\">"

    assert Parser.parse_html_min_position(html_snippet) == 0
  end

  test "parsing of display_name" do
    html_snippet = "<div class=\"tweet\" data-name=\"lola\"></div>"

    assert Parser.parse_display_name(html_snippet) == "lola"
  end

  test "parsing of user_id" do
    html_snippet = "<div class=\"tweet\" data-user-id=\"2\"></div>"

    assert Parser.parse_user_id(html_snippet) == 2
  end

  test "parsing of user_name" do
    html_snippet = "<div class=\"tweet\" data-screen-name=\"SomeUserName\"></div>"

    assert Parser.parse_user_name(html_snippet) == "SomeUserName"
  end

  test "parsing of tweet_id" do
    html_snippet = "<div class=\"tweet\" data-tweet-id=\"1\"></div>"

    assert Parser.parse_tweet_id(html_snippet) == 1
  end

  test "parsing of timestamp" do
    html_snippet = "<span class=\"_timestamp\" data-time-ms=\"1519339506000\"</span>"

    assert Parser.parse_timestamp(html_snippet) == "2018-02-22 22:45:06.000Z"
  end

  test "parsing of tweet_text" do
    html_snippet = "<p class=\"tweet-text\">some text</p>"

    assert Parser.parse_text(html_snippet) == "some text"
  end

  test "parsing of tweet_image" do
    html_snippet = """
      <div class=\"AdaptiveMedia-photoContainer\"
           data-image-url=\"https://pbs.twimg.com/media/123.jpg\">
      </div>
      """

    assert Parser.parse_image(html_snippet) == "https://pbs.twimg.com/media/123.jpg"
  end

  test "parsing of retweeter when it is a retweet" do
    html_snippet = "<div class=\"tweet\" data-retweeter=\"TorontoComms\"></div>"

    assert Parser.parse_is_retweet(html_snippet) == true
  end

  test "parsing of retweeter when it is not a retweet" do
    html_snippet = "<div class=\"tweet\"></div>"

    assert Parser.parse_is_retweet(html_snippet) == false
  end

  test "parsing of handle_id when it is not a retweet" do
    assert Parser.parse_handle_id(false, 123, "some html") == 123
  end

  test "parsing of handle_id when it is a retweet" do
    html_snippet = """
    <span class=\"js-retweet-text\">
     <a data-user-id=\"19377913\"><b>City of Toronto</b></a> Retweeted
    </span>
    """

    assert Parser.parse_handle_id(true, 123, html_snippet) == 19377913
  end

  test "truncation of text that does not exceed 30 chars" do
    assert Parser.truncate("some text") == "some text"
  end

  test "truncation of text over 30 chars is truncated" do
    text = "This is some text that is 31 ch"

    assert Parser.truncate(text) == "This is some text that is 31 c..."
  end
end
