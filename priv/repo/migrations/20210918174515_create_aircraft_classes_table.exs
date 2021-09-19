defmodule Logbook.Repo.Migrations.CreateAircraftClassesTable do
  use Ecto.Migration

  def change do
    create table(:aircraft_classes) do
      add :aircraft_category_id, references(:aircraft_categories, type: :id), null: false

      add :name, :string, null: false

      timestamps()
    end
  end
end
