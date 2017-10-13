use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :studio_superadmin, StudioSuperadminWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :studio_superadmin, StudioSuperadmin.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "",
  database: "studio",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
