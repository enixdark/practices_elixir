# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :plate_web,
  ecto_repos: [PlateWeb.Repo]

# Configures the endpoint
config :plate_web, PlateWebWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/Py90U66xYSyFd3xY/5OMUd0fDGKBOMVxZ0r6vUTmLfQaeGwEE60jX+RMWqkGKYB",
  render_errors: [view: PlateWebWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PlateWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
