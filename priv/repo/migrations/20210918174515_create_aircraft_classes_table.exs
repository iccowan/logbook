defmodule Logbook.Repo.Migrations.CreateAircraftClassesTable do
  use Ecto.Migration

  def change do
    create table(:aircraft_classes, primary_key: false) do
      add :id, :bigint, primary_key: true
      add :aircraft_category_id, references(:aircraft_categories, type: :bigint), null: false

      add :name, :string, null: false

      timestamps()
    end
  end
end
