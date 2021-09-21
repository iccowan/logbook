defmodule Logbook.BooksTestHelpers do
  @moduledoc """
  Test helpers for books
  """

  alias Logbook.Repo
  alias Logbook.Books
  alias Logbook.{AircraftTestHelpers, AirportsTestHelpers, UsersTestHelpers}

  defdelegate create_user(overrides \\ %{}), to: UsersTestHelpers
  defdelegate create_user!(overrides \\ %{}), to: UsersTestHelpers

  defdelegate create_airport(overrides \\ %{}), to: AirportsTestHelpers
  defdelegate create_airport!(overrides \\ %{}), to: AirportsTestHelpers

  defdelegate create_aircraft(overrides \\ %{}), to: AircraftTestHelpers
  defdelegate create_aircraft!(overrides \\ %{}), to: AircraftTestHelpers

  defdelegate create_aircraft_type(overrides \\ %{}), to: AircraftTestHelpers
  defdelegate create_aircraft_type!(overrides \\ %{}), to: AircraftTestHelpers

  def create_book(overrides \\ %{}) do
    %{
      name: "My Logbook",
      user_id: create_user!().id
    }
    |> Map.merge(overrides)
    |> Books.create_book()
  end

  def create_book!(overrides \\ %{}) do
    create_book(overrides)
    |> elem(1)
  end

  def update_book(book, overrides \\ %{}) do
    Books.update_book(book, overrides)
  end

  def update_book!(book, overrides \\ %{}) do
    update_book(book, overrides)
    |> elem(1)
  end

  def create_book_entry(overrides \\ %{}) do
    %{
      date: "2021-09-18",
      route: "KAND",
      book_id: create_book!().id,
      aircraft_id: create_aircraft!().id,
      apt_from_id: create_airport!().id,
      apt_to_id: create_airport!().id
    }
    |> Map.merge(overrides)
    |> Books.create_book_entry()
  end

  def create_book_entry!(overrides \\ %{}) do
    create_book_entry(overrides)
    |> elem(1)
  end

  def update_book_entry(book_entry, overrides \\ %{}) do
    Books.update_book_entry(book_entry, overrides)
  end

  def update_book_entry!(book_entry, overrides \\ %{}) do
    update_book_entry(book_entry, overrides)
    |> elem(1)
  end

  def create_book_entry_data(overrides \\ %{}) do
    book_field = create_book_field!() |> Logbook.Repo.preload(:book_field_type)

    %{
      book_field_id: book_field.id,
      book_entry_id: create_book_entry!().id,
      value: %{"val" => 3}
    }
    |> Map.merge(overrides)
    |> Books.create_book_entry_data()
  end

  def create_book_entry_data!(overrides \\ %{}) do
    create_book_entry_data(overrides)
    |> elem(1)
  end

  def update_book_entry_data(book_entry_data, overrides \\ %{}) do
    Books.update_book_entry_data(book_entry_data, overrides)
  end

  def update_book_entry_data!(book_entry_data, overrides \\ %{}) do
    update_book_entry_data(book_entry_data, overrides)
    |> elem(1)
  end

  def create_book_field(overrides \\ %{}) do
    [_book_type = %Books.BookFieldType{id: book_type_id} | _types] =
      Repo.all(Books.BookFieldType)

    %{
      name: "Total Time",
      desc: "Total time for the pilot",
      type_id: book_type_id,
      book_group_id: create_book_group!().id
    }
    |> Map.merge(overrides)
    |> Books.create_book_field()
  end

  def create_book_field!(overrides \\ %{}) do
    create_book_field(overrides)
    |> elem(1)
  end

  def update_book_field(book_field, overrides \\ %{}) do
    Books.update_book_field(book_field, overrides)
  end

  def update_book_field!(book_field, overrides \\ %{}) do
    update_book_field(book_field, overrides)
    |> elem(1)
  end

  def create_book_field_types(overrides \\ %{}) do
    book_field_types = [
      %Books.BookFieldType{
        name: "Integer",
        desc: "Whole Integer Number"
      },
      %Books.BookFieldType{
        name: "Decimal",
        desc: "Decimal Number"
      },
      %Books.BookFieldType{
        name: "Short Text",
        desc: "Short Text"
      },
      %Books.BookFieldType{
        name: "Long Text",
        desc: "Long Text"
      }
    ]

    Enum.each(book_field_types, fn type ->
      Repo.insert!(type)
    end)

    Repo.all(Books.BookFieldType)
  end

  def create_book_group(overrides \\ %{}) do
    %{
      name: "Default",
      book_id: create_book!().id
    }
    |> Map.merge(overrides)
    |> Books.create_book_group()
  end

  def create_book_group!(overrides \\ %{}) do
    create_book_group(overrides)
    |> elem(1)
  end

  def update_book_group(book_group, overrides \\ %{}) do
    Books.update_book_group(book_group, overrides)
  end

  def update_book_group!(book_group, overrides \\ %{}) do
    update_book_group(book_group, overrides)
    |> elem(1)
  end
end
