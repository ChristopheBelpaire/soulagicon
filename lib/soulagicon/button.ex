defmodule Soulagicon.Button do
  use GenServer
  require Logger
  @bounce_time 300

  def start_link(%{sensor_pin: sensor_pin, callback: callback}) do
    GenServer.start_link(__MODULE__, %{
      sensor_pin: sensor_pin,
      callback: callback
    })
  end

  def init(%{sensor_pin: sensor_pin, callback: callback}) do
    {:ok, gpio} = Circuits.GPIO.open(sensor_pin, :input, pull_mode: :pulldown)
    Circuits.GPIO.set_interrupts(gpio, :rising)

    {:ok,
     %{
       gpio: gpio,
       sensor_pin: sensor_pin,
       callback: callback,
       bounce: :os.system_time(:millisecond)
     }}
  end

  def handle_info(
        {:circuits_gpio, sensor_pin, _timestamp, value},
        state = %{sensor_pin: sensor_pin, callback: callback, bounce: bounce}
      ) do
    bounce =
      if :os.system_time(:millisecond) - @bounce_time > bounce do
        Logger.info("Pin #{sensor_pin} is #{value}")
        IO.inspect("Pin #{sensor_pin} is #{value}")
        callback.()
        :os.system_time(:millisecond)
      else
        bounce
      end

    {:noreply, %{state | bounce: bounce}}
  end
end
