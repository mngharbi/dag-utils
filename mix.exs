defmodule DagUtils.Mixfile do
  use Mix.Project

  def project do
  [
    app: :dag_utils,
    version: "1.0.0",
    elixir: "~> 1.4",
    build_embedded: Mix.env == :prod,
    start_permanent: Mix.env == :prod
  ]
  end
end
