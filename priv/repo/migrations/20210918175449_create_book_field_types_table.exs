defmodule Logbook.Repo.Migrations.CreateBookFieldTypesTable do
  use Ecto.Migration

  def change do
    create table(:book_field_types) do
      add :name, :string, null: false
      add :desc, :string

      timestamps()
    end
  end
end
