defmodule PlateWebWeb.PageController do
  use PlateWebWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
