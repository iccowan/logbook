defmodule Logbook.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :email, :string, null: false
      add :password, :string

      timestamps()
    end
  end
end
