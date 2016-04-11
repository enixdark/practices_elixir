defmodule SampleEcto.Repo.Migrations.SampleEcto.Repo do
  use Ecto.Migration

  def up do
  	"create table dquery(id serial primary key, title varchar(200), content varchar(200)"
  end

  def down do
  	"drop table dquery"
  end
end
