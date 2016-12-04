defmodule LoadLog.Mixfile do
  use Mix.Project

  def project do
    [app: :load_log,
     version: "0.1.0",
     elixir: "~> 1.3",
     description: "A simple OTP application that records CPU loadavg data",
     package: package(),
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
     {:credo, "~> 0.5.3", only: [:dev, :test]},
     {:ex_doc, "~> 0.14.5", only: [:dev]}]
  end

  defp package do
    [name: :load_log,
     maintainers: ["Dalgona"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/Dalgona/load_log"}]
  end
end
