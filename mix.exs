defmodule TwitterFeed.Mixfile do
  use Mix.Project

  def project do
    [
      app: :twitter_feed,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:excoveralls, "~> 0.8", only: :test},
      {:httpoison, "~> 1.0"},
      {:floki, "~> 0.20.0"},
      {:publicist, "~> 1.1"},
      {:ex_doc, "~> 0.18.0", only: :dev, runtime: false}
    ]
  end
end
