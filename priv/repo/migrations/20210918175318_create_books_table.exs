defmodule Logbook.Repo.Migrations.CreateBooksTable do
  use Ecto.Migration

  def change do
    create table(:books, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :binary_id), null: false

      add :name, :string, null: false

      timestamps()
    end
  end
end
