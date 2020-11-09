defmodule Oncrash.MixProject do
  use Mix.Project

  def project do
    [
      app: :oncrash,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Hex
      description: "OnCrash registering crash callbacks.",
      package: [
        licenses: ["Apache 2.0"],
        maintainers: ["Dominic Letz"],
        links: %{"GitHub" => "https://github.com/dominicletz/oncrash"}
      ],
      # Docs
      name: "OnCrash",
      source_url: "https://github.com/dominicletz/oncrash",
      docs: [
        # The main page in the docs
        main: "OnCrash",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:ex_doc, "~> 0.23", only: :dev, runtime: false}
    ]
  end
end
