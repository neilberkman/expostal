defmodule Expostal.MixProject do
  use Mix.Project

  @version "0.3.0"
  @source_url "https://github.com/neilberkman/expostal"

  def project do
    [
      app: :expostal,
      version: @version,
      elixir: "~> 1.15 or ~> 1.16 or ~> 1.17 or ~> 1.18",
      start_permanent: Mix.env() == :prod,
      compilers: [:elixir_make] ++ Mix.compilers(),
      make_targets: ["all"],
      make_clean: ["clean"],
      elixirc_paths: elixirc_paths(Mix.env()),
      docs: docs(),
      deps: deps(),
      description: description(),
      package: package(),
      dialyzer: [
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"},
        plt_add_apps: [:mix]
      ],
      name: "Expostal",
      source_url: @source_url,
      homepage_url: @source_url
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      # NIF building and precompilation
      {:elixir_make, "~> 0.9.0", runtime: false},
      {:cc_precompiler, "~> 0.1.0", runtime: false},

      # Development tools
      {:ex_doc, "~> 0.34", only: :dev, runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev], runtime: false},
      {:quokka, "~> 2.7", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.18", only: :test, runtime: false}
    ]
  end

  defp description do
    """
    Expostal is an Elixir binding for Openvenue's Libpostal.
    Expostal parses street address and expand address acroymes with high accuracy.
    """
  end

  defp package do
    [
      name: :expostal,
      files: [
        "src",
        "lib",
        "mix.exs",
        "README*",
        "LICENSE*",
        "Makefile",
        "Makefile.*",
        "checksum.exs"
      ],
      maintainers: ["Meng Xuan Xia"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => @source_url,
        "Original" => "https://github.com/SweetIQ/expostal"
      }
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md", "CHANGELOG.md"],
      source_ref: "v#{@version}",
      source_url: @source_url
    ]
  end
end
