defmodule DownloadCodeword.Mixfile do
  use Mix.Project

  def project do
    [ app: :download_codeword,
      version: "0.0.1",
      elixir: "~> 0.11",
      escript_main_module: DownloadCodeword,
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod:          { DownloadCodeword, [] },
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
