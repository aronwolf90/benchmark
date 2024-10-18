defmodule BenchmarkElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BenchmarkElixirWeb.Telemetry,
      BenchmarkElixir.Repo,
      {Ecto.Migrator,
        repos: Application.fetch_env!(:benchmark_elixir, :ecto_repos),
        skip: skip_migrations?()},
      {DNSCluster, query: Application.get_env(:benchmark_elixir, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: BenchmarkElixir.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: BenchmarkElixir.Finch},
      # Start a worker by calling: BenchmarkElixir.Worker.start_link(arg)
      # {BenchmarkElixir.Worker, arg},
      # Start to serve requests, typically the last entry
      BenchmarkElixirWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BenchmarkElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BenchmarkElixirWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp skip_migrations?() do
    # By default, sqlite migrations are run when using a release
    System.get_env("RELEASE_NAME") != nil
  end
end
