defmodule SampleEcto.Dquery do
	use Ecto.Schema

	schema "dquery" do
		field :content, :string
		field :title, :string
	end
end