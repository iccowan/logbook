defmodule Logbook.Repo.Migrations.CreateBookFieldsTable do
  use Ecto.Migration

  def change do
    create table(:book_fields, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :book_group_id, references(:book_groups, type: :binary_id), null: false
      add :type_id, references(:book_field_types, type: :bigint), null: false

      add :name, :string, null: false
      add :desc, :text

      timestamps()
    end
  end
end
