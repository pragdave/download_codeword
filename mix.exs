defmodule DlCodeword.Mixfile do
  use Mix.Project

  def project do
    [ app: :dl_codeword,
      version: "0.0.1",
      elixir: "~> 0.11",
      escript_main_module: DlCodeword,
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod:          { DlCodeword, [] },
      applications: [ :httpotion ] 
    ]
  end

  defp deps do
    [ 
     { :erlsom,    github: "willemdj/erlsom" },
     { :httpotion, github: "myfreeweb/httpotion" }
    ]
  end
end
