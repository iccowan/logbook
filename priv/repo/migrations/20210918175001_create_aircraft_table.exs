defmodule Logbook.Repo.Migrations.CreateAircraftTable do
  use Ecto.Migration

  def change do
    create table(:aircraft, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :aircraft_type_id, references(:aircraft_types, type: :binary_id), null: false
      add :home_base_apt_id, references(:airports, type: :binary_id)

      add :tail_number, :string, null: false
      add :notes, :text
      add :is_favorite, :boolean, null: false, default: false

      timestamps()
    end
  end
end
