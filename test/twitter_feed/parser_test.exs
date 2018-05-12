defmodule TwitterFeed.ParserTest do
  use ExUnit.Case, async: true

  alias TwitterFeed.Parser

  test "parsing of display_name" do
    html_snippet = "<div class=\"tweet\" data-name=\"lola\"></div>"

    assert Parser.parse_display_name(html_snippet) == "lola"
  end
end
