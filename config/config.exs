# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :logbook,
  ecto_repos: [Logbook.Repo]

# Configures the endpoint
config :logbook, LogbookWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base:
    "Z+j+HVTgKIsXG4fTEb5z6zFXQA968wgIqW8CaWnP8pvulz3gB2kYdl6WmDjCkRkR",
  render_errors: [
    view: LogbookWeb.ErrorView,
    accepts: ~w(html json),
    layout: false
  ],
  pubsub_server: Logbook.PubSub,
  live_view: [signing_salt: "CWKD3VE6"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
