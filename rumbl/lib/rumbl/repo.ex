defmodule Rumbl.Repo do
  use Ecto.Repo, otp_app: :rumbl
  @moduledoc """
  In memory repository.
  """
  # def all(Rumbl.User) do
  #   [%Rumbl.User{id: "1", name: "José", username: "josevalim", password: "elixir"},
  #   %Rumbl.User{id: "2", name: "Bruce", username: "redrapids", password: "7langs"},
  #   %Rumbl.User{id: "3", name: "Chris", username: "chrismccord", password: "phx"}]
  # end

  # def all(_module), do: []

  # def get(module, id) do
  #   all(module) |> Enum.find(fn map -> map.id == id end)
  # end

  # def get_by(module, params) do
  #   all(module) |> Enum.find(fn map ->
  #     params |> Enum.all?(fn (key, value) ->
  #       Map.get(map, key) == value
  #     end)
  #   end)
  # end

end
