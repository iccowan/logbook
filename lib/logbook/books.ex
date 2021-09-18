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
end
