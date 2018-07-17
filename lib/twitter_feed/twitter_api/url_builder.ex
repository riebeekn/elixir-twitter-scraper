defmodule TwitterFeed.TwitterApi.UrlBuilder do
  @moduledoc false

  @base_url "https://twitter.com"
  @profile_path "i/profiles/show"
  @timeline_path "timeline/tweets"
  @static_parameter_1 "include_available_features=1"
  @static_parameter_2 "include_entities=1"
  @dynamic_parameter "max_position"
  @static_parameter_3 "reset_error_state=false"
  @path_seperator "/"
  @query_seperator "&"

  def build_html_url(handle) do
    "#{@base_url}/#{handle}"
  end

  def build_json_url(handle, from_position) do
    @base_url <> @path_seperator <>
    @profile_path <> @path_seperator <>
    handle <> @path_seperator <>
    @timeline_path <> "?" <>
    @static_parameter_1 <> @query_seperator <>
    @static_parameter_2 <> @query_seperator <>
    @dynamic_parameter <> "=#{from_position}" <> @query_seperator <>
    @static_parameter_3
  end
end
