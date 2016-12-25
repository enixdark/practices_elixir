require IEx
defmodule Rumbl.UserController do
  use Rumbl.Web, :controller
  alias Rumbl.User

  plug :authenticate_user when action in [:index, :show]

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)
    IEx.pry
    case Repo.insert(changeset) do
       {:ok, user} ->
         conn |> Rumbl.Auth.login(user)
              |> put_flash(:info, "#{user.name} created")
              |> redirect(to: user_path(conn, :index))
       {:error, changeset} ->
         render conn, "new.html", changeset: changeset 
    end
    # {:ok, user} = Repo.insert(changeset)

  end

  def index(conn, _params) do
    # case authenticate(conn) do
    #   %Plug.Conn{halted: true} = conn -> 
    #     conn
    #   conn ->
    users = Repo.all(Rumbl.User)
    render conn, "index.html", users: users
    # end    
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(Rumbl.User, id)
    render conn, "show.html", user: user
  end

  # defp authenticate(conn, _opts) do
  #   if conn.assigns.current_user do
  #     conn
  #   else
  #     conn |> put_flash(:error, "You must be logged in to access that page")
  #          |> redirect(to: page_path(conn, :index))
  #          |> halt()
  #   end
  # end
end