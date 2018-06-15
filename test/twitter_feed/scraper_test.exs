defmodule TwitterFeed.ScraperTest do
  use ExUnit.Case, async: true

  alias TwitterFeed.{ Scraper }

  test "scraping on non-existant handle will return 404" do
    {:error, reason} = Scraper.scrape(:non_existant_handle, 0)

    assert reason =~ "404 error, that handle does not exist"
  end

  test "scraping the first page of tweets" do
    tweets = Scraper.scrape("someTwitterHandle", 0)

    assert Enum.count(tweets) == 20
    first_tweet = tweets |> hd()
    assert first_tweet.handle_id == 17055465
    assert first_tweet.tweet_id == 989880547399774209
    assert first_tweet.user_id == 17055465
    assert first_tweet.user_name == "lolagil"
    assert first_tweet.display_name == "lola"
    assert first_tweet.timestamp == "2018-04-27 14:54:48.000Z"
    assert first_tweet.text_summary == "Shed the Clutter @Spoke_Art NY..."
    assert first_tweet.image_url == "https://pbs.twimg.com/media/DbzDG7yU8AAfANg.jpg"
    assert first_tweet.retweet == false

    last_tweet = tweets |> List.last()
    assert last_tweet.handle_id == 17055465
    assert last_tweet.tweet_id == 948266826315829248
    assert last_tweet.user_id == 3367318323
    assert last_tweet.user_name == "viviunuu"
    assert last_tweet.display_name == "culera"
    assert last_tweet.timestamp == "2018-01-02 18:56:43.000Z"
    assert last_tweet.text_summary == "this is how much i’m striving ..."
    assert last_tweet.image_url == "https://pbs.twimg.com/media/DSjrplLXcAA0j-S.jpg"
    assert last_tweet.retweet == true
  end

  test "scraping the second page of tweets" do
    tweets = Scraper.scrape("someTwitterHandle", 1234)

    assert Enum.count(tweets) == 19
    first_tweet = tweets |> hd()
    assert first_tweet.handle_id == 17055465
    assert first_tweet.tweet_id == 948736761848565766
    assert first_tweet.user_id == 2189503302
    assert first_tweet.user_name == "NYTMinusContext"
    assert first_tweet.display_name == "NYT Minus Context"
    assert first_tweet.timestamp == "2018-01-04 02:04:05.000Z"
    assert first_tweet.text_summary == "you just have to take people i..."
    assert first_tweet.image_url == ""
    assert first_tweet.retweet == true

    last_tweet = tweets |> List.last()
    assert last_tweet.handle_id == 17055465
    assert last_tweet.tweet_id == 915946122274791425
    assert last_tweet.user_id == 17055465
    assert last_tweet.user_name == "lolagil"
    assert last_tweet.display_name == "lola"
    assert last_tweet.timestamp == "2017-10-05 14:25:47.000Z"
    assert last_tweet.text_summary == "Can NOT wait!!!https://twitter..."
    assert last_tweet.image_url == ""
    assert last_tweet.retweet == false
  end
end
