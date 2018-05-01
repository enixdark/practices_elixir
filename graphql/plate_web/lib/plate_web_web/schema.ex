defmodule PlateWebWeb.Schema do
  use Absinthe.Schema
  alias PlateWeb.{Menu, Repo}
  alias PlateWebWeb.Resolvers
  import Ecto.Query

  enum :sort_order do
    value :asc
    value :desc
  end

  @desc "Filtering options for the menu item list"
  input_object :menu_item_filter do
    @desc "Matching a name"
    field :name, :string

    @desc "Matching a category name"
    field :category, non_null(:string)

    @desc "Matching a tag"
    field :tag, :string

    @desc "Priced above a value"
    field :priced_above, :float

    @desc "Priced below a value"
    field :priced_below, :float
  end

  query do

    @desc "The list of available items on the menu"
    field :menu_items, list_of(:menu_item),
      description: "the list of available items on the menu" do

      arg :filter, non_null(:menu_item_filter)
      arg :matching, :string

      @desc "sort by name"
      arg :order, type: :sort_order, default_value: :asc

      resolve &Resolvers.Menu.menu_items/3
      # resolve fn
      #   _, %{matching: name}, _ when is_binary(name) ->
      #     query = from t in Menu.Item, where: ilike(t.name, ^"%#{name}%")
      #     {:ok, Repo.all(query)}
      #   _, _, _ ->
      #     {:ok, Repo.all(Menu.Item)}
      # end
    end
  end

  object :menu_item do
    field :id, :id
    field :name, :string
    field :desription, :string
  end
end
