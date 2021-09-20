defmodule Logbook.Books do
  @moduledoc """
  Books context
  """

  import Ecto.Query, warn: false

  alias Logbook.{Books, Users}
  alias Logbook.Repo

  @spec create_book(map()) :: Books.Book.t()
  def create_book(attrs \\ %{}) do
    %Books.Book{}
    |> Books.Book.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_book(Books.Book.t(), map()) :: Books.Book.t()
  def update_book(book = %Books.Book{}, attrs \\ %{}) do
    book
    |> Books.Book.changeset(attrs)
    |> Repo.update()
  end

  @spec create_book_entry(map()) :: Books.BookEntry.t()
  def create_book_entry(attrs \\ %{}) do
    %Books.BookEntry{}
    |> Books.BookEntry.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_book_entry(Books.BookEntry.t(), map()) :: Books.BookEntry.t()
  def update_book_entry(book_entry = %Books.BookEntry{}, attrs \\ %{}) do
    book_entry
    |> Books.BookEntry.changeset(attrs)
    |> Repo.update()
  end

  @spec create_book_field(map()) :: Books.BookField.t()
  def create_book_field(attrs \\ %{}) do
    %Books.BookField{}
    |> Books.BookField.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_book_field(Books.BookField.t(), map()) :: Books.BookField.t()
  def update_book_field(book_field = %Books.BookField{}, attrs \\ %{}) do
    book_field
    |> Books.BookField.changeset(attrs)
    |> Repo.update()
  end

  @spec create_book_field_type(map()) :: Books.BookFieldType.t()
  def create_book_field_type(attrs \\ %{}) do
    %Books.BookFieldType{}
    |> Books.BookFieldType.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_book_field_type(Books.BookFieldType.t(), map()) ::
          Books.BookFieldType.t()
  def update_book_field_type(book_field_type, attrs \\ %{}) do
    book_field_type
    |> Books.BookFieldType.changeset(attrs)
    |> Repo.update()
  end

  @spec create_book_group(map()) :: Books.BookGroup.t()
  def create_book_group(attrs \\ %{}) do
    %Books.BookGroup{}
    |> Books.BookGroup.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_book_group(Books.BookGroup.t(), map()) :: Books.BookGroup.t()
  def update_book_group(book_group, attrs \\ %{}) do
    book_group
    |> Books.BookGroup.changeset(attrs)
    |> Repo.update()
  end

  @spec create_book_entry_data(map()) :: Books.BookEntryData.t()
  def create_book_entry_data(attrs \\ %{}) do
    %Books.BookEntryData{}
    |> Books.BookEntryData.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_book_entry_data(Books.BookEntryData.t(), map()) ::
          Books.BookEntryData.t()
  def update_book_entry_data(book_entry_data, attrs \\ %{}) do
    book_entry_data
    |> Books.BookEntryData.changeset(attrs)
    |> Repo.update()
  end

  @spec get_books_by_user(Users.User.t()) :: [Books.Book.t()]
  def get_books_by_user(_user = %Users.User{id: user_id}) do
    Repo.all(
      from b in Books.Book,
        where: b.user_id == ^user_id
    )
  end

  @spec get_book_entries_by_book(Books.Book.t()) :: [Books.BookEntry.t()]
  def get_book_entries_by_book(_book = %Books.Book{id: book_id}) do
    Repo.all(
      from be in Books.BookEntry,
        where: be.book_id == ^book_id
    )
  end

  @spec get_book_groups_by_book(Books.Book.t()) :: [Books.BookGroup.t()]
  def get_book_groups_by_book(_book = %Books.Book{id: book_id}) do
    Repo.all(
      from bg in Books.BookGroup,
        where: bg.book_id == ^book_id
    )
  end

  @spec get_book_fields_by_group(Books.BookGroup.t()) :: [Books.BookField.t()]
  def get_book_fields_by_group(_book = %Books.BookGroup{id: group_id}) do
    Repo.all(
      from bf in Books.BookField,
        where: bf.book_group_id == ^group_id
    )
  end

  @spec get_book_entry_data_field_type(Books.BookEntryData.t()) ::
          Books.BookFieldType.t()
  def get_book_entry_data_field_type(book_entry_data = %Books.BookEntryData{}) do
    book_entry_data
    |> Repo.preload(:book_field)
    |> Map.get(:book_field)
    |> Repo.preload(:book_field_type)
    |> Map.get(:book_field_type)
  end
end
