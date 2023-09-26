defmodule Soulagicon do
  use GenServer
  require Logger
  alias Soulagicon.SoundPlayer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: :soulagicon)
  end

  def init(_) do
    {:ok, :idle}
  end

  def coin() do
    GenServer.cast(:soulagicon, :coin)
  end

  def shboing() do
    GenServer.cast(:soulagicon, :shboing)
  end

  def handle_cast(:coin, _) do
    SoundPlayer.stop_sound()
    SoundPlayer.play_sentence()
    IO.puts("coin")
    {:noreply, :playing}
  end

  def handle_cast(:shboing, :idle) do
    {:noreply, :idle}
  end

  def handle_cast(:shboing, _) do
    SoundPlayer.stop_sound()
    SoundPlayer.play_shboing()
    IO.puts("Shboing")

    {:noreply, :idle}
  end
end
