defmodule BenchmarkElixir.Repo do
  use Ecto.Repo,
    otp_app: :benchmark_elixir,
    adapter: Ecto.Adapters.SQLite3
end
