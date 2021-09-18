defmodule Logbook.Repo.Migrations.CreateAirportsTable do
  use Ecto.Migration

  def change do
    create table(:airports, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :binary_id), null: false

      add :code, :string, null: false
      add :name, :string, null: false
      add :location, :string
      add :is_favorite, :boolean, null: false, default: false

      timestamps()
    end
  end
end
