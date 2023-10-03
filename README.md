# Snulskit Soulagicon**

Pour fabriquer ton propre soulagicon, il de faudra les ingredients usuels suivant :
  *  une raspberry pi, peut importe le modèle
  *  un bouton ou capteur servant de monnayeur, celui ci se conectera à la GPIO numéro 14
  *  un (solide) boutonn, servant à se soulager, à connecter a la GPIO 15
  *  une carte SD
 
https://github.com/ChristopheBelpaire/soulagicon/assets/137277/4e5585e7-fb96-469c-b527-5fa1e96fbef1



## Targets

Nerves applications produce images for hardware targets based on the
`MIX_TARGET` environment variable. If `MIX_TARGET` is unset, `mix` builds an
image that runs on the host (e.g., your laptop). This is useful for executing
logic tests, running utilities, and debugging. Other targets are represented by
a short name like `rpi3` that maps to a Nerves system image for that platform.
All of this logic is in the generated `mix.exs` and may be customized. For more
information about targets see:

https://hexdocs.pm/nerves/targets.html#content

## Getting Started

To start your Nerves app:
  * `export MIX_TARGET=my_target` or prefix every command with
    `MIX_TARGET=my_target`. For example, `MIX_TARGET=rpi3`
  * Install dependencies with `mix deps.get`
  * Create firmware with `mix firmware`
  * Burn to an SD card with `mix burn`

## Learn more

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: https://nerves-project.org/
  * Forum: https://elixirforum.com/c/nerves-forum
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves
