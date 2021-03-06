# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :etalon_equipment,
  ecto_repos: [EtalonEquipment.Repo]

# Configures the endpoint
config :etalon_equipment, EtalonEquipmentWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+qkP8j3ijv6iEH7Hlt+w5S9NcgsEvBBrLEyjMB+FQSDwIFkTftxmFyi7J/j2Wy3w",
  render_errors: [view: EtalonEquipmentWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: EtalonEquipment.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
