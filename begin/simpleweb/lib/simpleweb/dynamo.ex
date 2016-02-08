defmodule Simpleweb.Dynamo do
  use Dynamo

  config :dynamo,
    # The environment this Dynamo runs on
    env: Mix.env,

    # The OTP application associated with this Dynamo
    otp_app: :simpleweb,

    # The endpoint to dispatch requests to
    endpoint: ApplicationRouter,

    # The route from which static assets are served
    # You can turn off static assets by setting it to false
    static_route: "/static"

  # Uncomment the lines below to enable the cookie session store
  # config :dynamo,
  #   session_store: Session.CookieStore,
  #   session_options:
  #     [ key: "_simpleweb_session",
  #       secret: "8DBeyrh8/lbbFlwaLuN5DQa4dwbNJ8m1iquNRY8HS19kwg2miZPWZEm9LMl2eQbs"]

  # Default functionality available in templates
  templates do
    use Dynamo.Helpers
  end
end
