defmodule Logbook.Repo.Migrations.CreateAircraftCategoriesTable do
  use Ecto.Migration

  def change do
    create table(:aircraft_categories, primary_key: false) do
      add :id, :bigint, primary_key: true

      add :name, :string, null: false

      timestamps()
    end
  end
end
