defmodule Logbook.Books do
  @moduledoc """
  Books context
  """

  import Ecto.Query, warn: false

  alias Logbook.Books
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
end
