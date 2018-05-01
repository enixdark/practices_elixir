defmodule PlateWebWeb.Resolvers.Menu do
  alias PlateWeb.Menu

  def menu_items(_, args, _) do
    {:ok, Menu.list_items(args)}
  end
end
