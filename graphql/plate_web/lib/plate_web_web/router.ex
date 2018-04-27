defmodule PlateWebWeb.Router do
  use PlateWebWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # scope "/", PlateWebWeb do
  #   pipe_through :browser # Use the default browser stack

  #   get "/", PageController, :index
  # end

  scope "/" do
    pipe_through :api

    forward "/api" , Absinthe.Plug,
      schema: PlateWebWeb.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: PlateWebWeb.Schema,
      interface: :simple
  end

  # Other scopes may use custom stacks.
  # scope "/api", PlateWebWeb do
  #   pipe_through :api
  # end
end
