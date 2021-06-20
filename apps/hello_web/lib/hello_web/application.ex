defmodule HelloWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
#      # Start the Telemetry supervisor
#      HelloWeb.Telemetry,
#      # Start the Endpoint (http/https)
#      HelloWeb.Endpoint
#      # Start a worker by calling: HelloWeb.Worker.start_link(arg)
#      # {HelloWeb.Worker, arg}

#       HelloWeb.Endpoint

#      HelloWeb.Telemetry,
#      HelloWeb.Endpoint,
#      {Phoenix.PubSub, name: HelloWeb.PubSub, adapter: Phoenix.PubSub.PG2},
#      HelloWeb.Presence


      Hello.Repo,

      HelloWeb.Endpoint,
      {Phoenix.PubSub, name: HelloWeb.PubSub},
      HelloWeb.Presence

    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    HelloWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
