defmodule PlateWebWeb.Schema do
  use Absinthe.Schema
  alias PlateWeb.{Menu, Repo}
  query do

    @desc "The list of available items on the menu"
    field :menu_items, list_of(:menu_item),
      description: "the list of available items on the menu" do
      resolve fn _, _, _ ->
        {:ok, Repo.all(Menu.Item)}
      end
    end
  end

  object :menu_item do
    field :id, :id
    field :name, :string
    field :desription, :string
  end
end
