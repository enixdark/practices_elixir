defmodule Rumbl.Video do
  use Rumbl.Web, :model

  @required_fields ~w(url title description)
  @optional_fields ~w(category_id)

  schema "videos" do
    field :url, :string
    field :title, :string
    field :description, :string
    belongs_to :user, Rumbl.User
    belongs_to :category, Rumbl.Categories
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields )
    |> validate_required(@required_fields)
    |> assoc_contraint(:category)
  end
end
