use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :plate_web, PlateWebWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :plate_web, PlateWeb.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "admin",
  password: "admin",
  database: "plate",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
