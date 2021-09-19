defmodule Logbook.Repo.Migrations.CreateBookEntryDataTable do
  use Ecto.Migration

  def change do
    create table(:book_entry_data, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :book_field_id, references(:book_fields, type: :binary_id), null: false
      add :book_entry_id, references(:book_entries, type: :binary_id), null: false

      add :value, :map, null: false

      timestamps()
    end
  end
end
