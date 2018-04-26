defmodule TwitterFeed.ScraperTest do
  use ExUnit.Case, async: true

  alias TwitterFeed.{ Scraper }

  test "scraping on non-existant handle will return 404" do
    {:error, reason} = Scraper.scrape(:non_existant_handle, 1, 0)

    assert reason =~ "404 error, that handle does not exist"
  end

  test "scraping on valid handle will return some body content" do
    body = Scraper.scrape(:any_handle, 1, 0)

    assert body =~ "This handle looks good!"
  end
end
