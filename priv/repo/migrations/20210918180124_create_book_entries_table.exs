defmodule Logbook.Repo.Migrations.CreateBookEntriesTable do
  use Ecto.Migration

  def change do
    create table(:book_entries, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :book_id, references(:books, type: :binary_id), null: false
      add :aircraft_id, references(:aircraft, type: :binary_id), null: false
      add :apt_from_id, references(:airports, type: :binary_id), null: false
      add :apt_to_id, references(:airports, type: :binary_id), null: false

      add :route, :text
      add :date, :date

      timestamps()
    end
  end
end
