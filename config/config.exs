# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :discuss,
  ecto_repos: [Discuss.Repo]

# Configures the endpoint
config :discuss, DiscussWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "V41QIRfi2tQTcat7ZU1saSxyQ1yKt3JFLwoQvcG2dr1BInUav4quDmZaZRnf66Ll",
  render_errors: [view: DiscussWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Discuss.PubSub,
  live_view: [signing_salt: "zbWVHHAL"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
providers: [
  github: { Ueberauth.Strategy.Github, [default_scope: "user,user:email,public_repo"] }
]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: "7cdf7278d7c5ffa5d9b8",
  client_secret: "38d0b6dcb5f3c8c2a55420310fac0341dccfce0e"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
