defmodule Logbook.Repo.Migrations.CreateAircraftTypesTable do
  use Ecto.Migration

  def change do
    create table(:aircraft_types, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :binary_id), null: false
      add :aircraft_class_id, references(:aircraft_classes, type: :id)

      add :name, :string, null: false
      add :make, :string
      add :model, :string
      add :engine, :string
      add :complex, :boolean, null: false, default: false
      add :high_performance, :boolean, null: false, default: false
      add :high_altitude, :boolean, null: false, default: false
      add :tailwheel, :boolean, null: false, default: false

      timestamps()
    end
  end
end
