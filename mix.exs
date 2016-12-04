defmodule LoadLog.Mixfile do
  use Mix.Project

  def project do
    [app: :load_log,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger, :os_mon],
     mod: {LoadLog, []}]
  end

  defp deps do
    [{:dialyxir, "~> 0.4.1", only: [:dev, :test]},
     {:credo, "~> 0.5.3", only: [:dev, :test]}]
  end
end
