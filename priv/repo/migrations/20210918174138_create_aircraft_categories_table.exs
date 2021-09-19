defmodule Logbook.Repo.Migrations.CreateAircraftCategoriesTable do
  use Ecto.Migration

  def change do
    create table(:aircraft_categories) do
      add :name, :string, null: false

      timestamps()
    end
  end
end
