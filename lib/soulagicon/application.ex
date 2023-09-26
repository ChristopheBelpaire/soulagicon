defmodule Soulagicon.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Soulagicon.Supervisor]

    children =
      [
        # Children for all targets
        # Starts a worker by calling: Soulagicon.Worker.start_link(arg)
        # {Soulagicon.Worker, arg},
        Supervisor.child_spec(
          {Soulagicon.Button, %{sensor_pin: 14, callback: &Soulagicon.coin/0}},
          id: :button_14
        ),
        Supervisor.child_spec(
          {Soulagicon.Button, %{sensor_pin: 15, callback: &Soulagicon.shboing/0}},
          id: :button_15
        ),
        {Soulagicon, []},
        {Soulagicon.SoundPlayer, []}
      ] ++ children(target())

    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  def children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: Soulagicon.Worker.start_link(arg)
      # {Soulagicon.Worker, arg},
    ]
  end

  def children(_target) do
    [
      # Children for all targets except host
      # Starts a worker by calling: Soulagicon.Worker.start_link(arg)
      # {Soulagicon.Worker, arg},
    ]
  end

  def target() do
    Application.get_env(:soulagicon, :target)
  end
end
