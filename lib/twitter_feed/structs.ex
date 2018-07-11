defmodule TwitterFeed.Feed do
  @moduledoc """
  Struct representing a twitter feed.

  ## Fields

  - last_tweet_retrieved: the id of the last tweet retrieved.
  - more_tweets_exist: true | false indicator of whether there are more tweets.
  - tweets: [%TwitterFeed.Tweet] - a list of the tweets retrieved.
  """
  defstruct [
    last_tweet_retrieved: 0,
    more_tweets_exist: false,
    tweets: []
  ]
end

defmodule TwitterFeed.Tweet do
  @moduledoc """
  Struct representing a tweet.

  ## Fields

  - handle_id: the handle of the current feed the tweet appears in.
  - tweet_id: the id of the tweet.
  - user_id: the user id associated with the tweet.
  - user_name: the twitter handle associated with the tweet.
  - display_name: the display name associated with the tweet.
  - timestamp: the date / time the tweet was posted.
  - text_summary: a summary of the tweet text.
  - image_url: the url of any image contained in the tweet.
  - retweet: true | false indicator of whether the tweet is a retweet.
  """
  defstruct [
    handle_id: "",
    tweet_id: "",
    user_id: "",
    user_name: "",
    display_name: "",
    timestamp: "",
    text_summary: "",
    image_url: "",
    retweet: false
  ]
end
