defmodule Logbook.Repo.Migrations.CreateBookGroupsTable do
  use Ecto.Migration

  def change do
    create table(:book_groups, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :book_id, references(:books, type: :binary_id), null: false

      add :name, :string, null: false

      timestamps()
    end
  end
end
