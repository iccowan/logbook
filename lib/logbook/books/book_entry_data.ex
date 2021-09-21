defmodule Logbook.Books.BookEntryData do
  @moduledoc """
  BookEntryData schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Logbook.Repo
  alias Logbook.Books
  alias Logbook.Books.BookEntryData
  alias Logbook.Books.{BookEntry, BookField, BookFieldType}

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "book_entry_data" do
    field :value, :map

    timestamps()

    belongs_to :book_field, BookField,
      foreign_key: :book_field_id,
      type: :binary_id

    belongs_to :book_entry, BookEntry,
      foreign_key: :book_entry_id,
      type: :binary_id
  end

  @type t :: %__MODULE__{
          id: Ecto.UUID.t(),
          value: map(),
          book_field: BookField.t(),
          book_field_id: Ecto.UUID.t(),
          book_entry: BookEntry.t(),
          book_entry_id: Ecto.UUID.t(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  def changeset(book_entry_data = %BookEntryData{}, attrs \\ %{}) do
    book_entry_data
    |> cast(attrs, [:book_field_id, :book_entry_id, :value])
    |> validate_required([:book_field_id, :book_entry_id, :value])
    |> validate_type_of_data()
  end

  defp validate_type_of_data(changeset = %{valid?: false}), do: changeset

  defp validate_type_of_data(changeset = %{changes: %{value: value}}),
    do: validate_type_of_data_helper(changeset, value)

  defp validate_type_of_data(changeset), do: changeset

  defp validate_type_of_data_helper(
         changeset = %{changes: %{book_field_id: book_field_id}},
         value
       ) do
    Repo.get!(BookField, book_field_id)
    |> Repo.preload(:book_field_type)
    |> Map.get(:book_field_type)
    |> validate_type_of_data_helper_2(changeset, value)
  end

  defp validate_type_of_data_helper(
         changeset = %{data: book_entry_data = %BookEntryData{}},
         value
       ) do
    book_entry_data
    |> Books.get_book_entry_data_field_type()
    |> validate_type_of_data_helper_2(changeset, value)
  end

  defp validate_type_of_data_helper_2(
         field_type = %BookFieldType{name: "Integer"},
         changeset,
         value
       ) do
    validate_change(changeset, :value, fn :value, _value ->
      case value |> Map.get("val") |> is_integer() do
        true -> []
        false -> [value: "is wrong type, expecting integer"]
      end
    end)
  end

  defp validate_type_of_data_helper_2(
         field_type = %BookFieldType{name: "Decimal"},
         changeset,
         value
       ) do
    validate_change(changeset, :value, fn :value, _value ->
      case value |> Map.get("val") |> is_float() ||
             value |> Map.get("val") |> is_integer() do
        true -> []
        false -> [value: "is wrong type, expecting float or integer"]
      end
    end)
  end

  defp validate_type_of_data_helper_2(
         field_type = %BookFieldType{name: "Short Text"},
         changeset,
         value
       ) do
    validate_string(value, changeset)
  end

  defp validate_type_of_data_helper_2(
         field_type = %BookFieldType{name: "Long Text"},
         changeset,
         value
       ) do
    validate_string(value, changeset)
  end

  defp validate_string(value, changeset) do
    validate_change(changeset, :value, fn :value, _value ->
      case value |> Map.get("val") |> is_binary() do
        true -> []
        false -> [value: "is wrong type, expecting binary"]
      end
    end)
  end
end
