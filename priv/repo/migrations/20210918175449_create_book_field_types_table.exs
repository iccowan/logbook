defmodule Logbook.Repo.Migrations.CreateBookFieldTypesTable do
  use Ecto.Migration

  def change do
    create table(:book_field_types, primary_key: false) do
      add :id, :bigint, primary_key: true

      add :name, :string, null: false
      add :desc, :string, null: false

      timestamps()
    end
  end
end
