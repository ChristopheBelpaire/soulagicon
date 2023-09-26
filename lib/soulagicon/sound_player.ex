defmodule Soulagicon.SoundPlayer do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: :soundplayer)
  end

  def init(_) do
    {:ok, :idle}
  end

  def play_sentence() do
    GenServer.cast(:soundplayer, :play_sentence)
  end

  def play_shboing() do
    GenServer.cast(:soundplayer, :play_shboing)
  end

  def stop_sound() do
    :os.cmd(~c"killall #{audio_player()}")
  end

  def handle_cast(:play_sentence, state) do
    Path.join(:code.priv_dir(:soulagicon), "sounds")
    |> File.ls!()
    |> Enum.random()
    |> play_sound("sounds")

    {:noreply, state}
  end

  def handle_cast(:play_shboing, state) do
    play_sound("shboing.wav", "")
    {:noreply, state}
  end

  defp play_sound(file_name, folder) do
    static_directory_path = Path.join(:code.priv_dir(:soulagicon), folder)
    full_path = Path.join(static_directory_path, file_name)
    :os.cmd(~c"#{audio_player_cmd()} #{full_path}")
  end

  defp audio_player() do
    if Nerves.Runtime.mix_target() in [:rpi, :rpi2, :rpi3, :rpi4], do: "aplay", else: "afplay"
  end

  defp audio_player_cmd() do
    if Nerves.Runtime.mix_target() in [:rpi, :rpi2, :rpi3, :rpi4],
      do: "#{audio_player()} -q",
      else: "#{audio_player()}"
  end
end
