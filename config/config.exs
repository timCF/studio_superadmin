# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :studio_superadmin,
  ecto_repos: [StudioSuperadmin.Repo]

# Configures the endpoint
config :studio_superadmin, StudioSuperadminWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2LB/IQJbrHEUb8tLefjixG9v1eF4kPZ+KPrknQ6VcF6AAHBPChAopr0aXnYHXoVY",
  render_errors: [view: StudioSuperadminWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: StudioSuperadmin.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
