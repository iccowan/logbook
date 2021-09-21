defmodule Logbook.BooksTest do
  use Logbook.DataCase, async: true
  doctest Logbook.Books

  alias Logbook.{Airports, Aircraft, Books, Users}
  alias Logbook.BooksTestHelpers, as: Helpers

  setup do
    user = Helpers.create_user!()

    %Aircraft.AircraftType{id: at_id} =
      Helpers.create_aircraft_type!(%{user_id: user.id})

    aircraft = Helpers.create_aircraft!(%{aircraft_type: at_id})
    airport_dep = Helpers.create_airport!(%{user_id: user.id})
    airport_arr = Helpers.create_airport!(%{user_id: user.id})

    book = Helpers.create_book!(%{user_id: user.id})

    book_entry =
      Helpers.create_book_entry!(%{
        book_id: book.id,
        aircraft_id: aircraft.id,
        apt_from_id: airport_dep.id,
        apt_to_id: airport_arr.id
      })

    book_field_type = Helpers.create_book_field_type!()
    book_group = Helpers.create_book_group!(%{book_id: book.id})

    book_field =
      Helpers.create_book_field!(%{
        type_id: book_field_type.id,
        book_group_id: book_group.id
      })

    book_entry_data =
      Helpers.create_book_entry_data!(%{
        book_field_id: book_field.id,
        book_entry_id: book_entry.id
      })

    {
      :ok,
      book: book,
      book_entry: book_entry,
      book_entry_data: book_entry_data,
      book_field_type: book_field_type,
      book_field: book_field,
      book_group: book_group,
      user: user,
      aircraft: aircraft,
      airport_dep: airport_dep,
      airport_arr: airport_arr
    }
  end

  test "creating a new book creates the book", %{book: book} do
    assert Repo.exists?(from b in Books.Book, where: b.id == ^book.id)
  end

  test "creating a new book_entry creates the book_entry", %{
    book_entry: book_entry
  } do
    assert Repo.exists?(
             from b in Books.BookEntry, where: b.id == ^book_entry.id
           )
  end

  test "creating a new book_entry_data creates the book_entry_data", %{
    book_entry_data: book_entry_data
  } do
    assert Repo.exists?(
             from b in Books.BookEntryData, where: b.id == ^book_entry_data.id
           )
  end

  test "creating a new book_field_type creates the book_field_type", %{
    book_field_type: book_field_type
  } do
    assert Repo.exists?(
             from b in Books.BookFieldType, where: b.id == ^book_field_type.id
           )
  end

  test "creating a new book_field creates the book_field", %{
    book_field: book_field
  } do
    assert Repo.exists?(
             from b in Books.BookField, where: b.id == ^book_field.id
           )
  end

  test "creating a new book_group creates the book_group", %{
    book_group: book_group
  } do
    assert Repo.exists?(
             from b in Books.BookGroup, where: b.id == ^book_group.id
           )
  end

  test "book name is required" do
    {success, _book} = Helpers.create_book(%{name: nil})
    assert success == :error
  end

  test "book user_id is required" do
    {success, _book} = Helpers.create_book(%{user_id: nil})
    assert success == :error
  end

  test "book name updates on update", %{book: book} do
    Helpers.update_book(book, %{name: "This is a new name"})
    %Books.Book{name: name} = Repo.get(Books.Book, book.id)
    assert name == "This is a new name"
  end

  test "book user_id updates on update", %{book: book} do
    %Users.User{id: u_id} = Helpers.create_user!()
    Helpers.update_book(book, %{user_id: u_id})
    %Books.Book{user_id: new_u_id} = Repo.get(Books.Book, book.id)
    assert new_u_id == u_id
  end

  test "book_entry date is required" do
    {success, _book_entry} = Helpers.create_book_entry(%{date: nil})
    assert success == :error
  end

  test "book_entry book_id is required" do
    {success, _book_entry} = Helpers.create_book_entry(%{book_id: nil})
    assert success == :error
  end

  test "book_entry aircraft_id is required" do
    {success, _book_entry} = Helpers.create_book_entry(%{aircraft_id: nil})
    assert success == :error
  end

  test "book_entry apt_from_id is required" do
    {success, _book_entry} = Helpers.create_book_entry(%{apt_from_id: nil})
    assert success == :error
  end

  test "book_entry apt_to_id is required" do
    {success, _book_entry} = Helpers.create_book_entry(%{apt_to_id: nil})
    assert success == :error
  end

  test "book_entry route is not required" do
    {success, _book_entry} = Helpers.create_book_entry(%{route: nil})
    assert success == :ok
  end

  test "book_entry date updates on update", %{book_entry: book_entry} do
    Helpers.update_book_entry(book_entry, %{date: "2021-01-03"})
    %Books.BookEntry{date: date} = Repo.get(Books.BookEntry, book_entry.id)
    assert date == ~D[2021-01-03]
  end

  test "book_entry route updates on update", %{book_entry: book_entry} do
    Helpers.update_book_entry(book_entry, %{route: "KAVL KDVK"})
    %Books.BookEntry{route: route} = Repo.get(Books.BookEntry, book_entry.id)
    assert route == "KAVL KDVK"
  end

  test "book_entry book_id updates on update", %{book_entry: book_entry} do
    %Books.Book{id: new_id} = Helpers.create_book!()
    Helpers.update_book_entry(book_entry, %{book_id: new_id})
    %Books.BookEntry{book_id: id} = Repo.get(Books.BookEntry, book_entry.id)
    assert id == new_id
  end

  test "book_entry aircraft_id updates on update", %{book_entry: book_entry} do
    %Aircraft.Aircraft{id: new_id} = Helpers.create_aircraft!()
    Helpers.update_book_entry(book_entry, %{aircraft_id: new_id})
    %Books.BookEntry{aircraft_id: id} = Repo.get(Books.BookEntry, book_entry.id)
    assert id == new_id
  end

  test "book_entry apt_from_id updates on update", %{book_entry: book_entry} do
    %Airports.Airport{id: new_id} = Helpers.create_airport!()
    Helpers.update_book_entry(book_entry, %{apt_from_id: new_id})
    %Books.BookEntry{apt_from_id: id} = Repo.get(Books.BookEntry, book_entry.id)
    assert id == new_id
  end

  test "book_entry apt_to_id updates on update", %{book_entry: book_entry} do
    %Airports.Airport{id: new_id} = Helpers.create_airport!()
    Helpers.update_book_entry(book_entry, %{apt_to_id: new_id})
    %Books.BookEntry{apt_to_id: id} = Repo.get(Books.BookEntry, book_entry.id)
    assert id == new_id
  end

  test "book_entry_data book_field_id is required" do
    {success, _book_entry_data} =
      Helpers.create_book_entry_data(%{book_field_id: nil})

    assert success == :error
  end

  test "book_entry_data book_entry_id is required" do
    {success, _book_entry_data} =
      Helpers.create_book_entry_data(%{book_entry_id: nil})

    assert success == :error
  end

  test "book_entry_data value is required" do
    {success, _book_entry_data} = Helpers.create_book_entry_data(%{value: nil})
    assert success == :error
  end

  test "book_entry_data book_field_id updates on update", %{
    book_entry_data: book_entry_data
  } do
    %Books.BookField{id: new_id} = Helpers.create_book_field!()
    Helpers.update_book_entry_data(book_entry_data, %{book_field_id: new_id})

    %Books.BookEntryData{book_field_id: id} =
      Repo.get(Books.BookEntryData, book_entry_data.id)

    assert id == new_id
  end

  test "book_entry_data book_entry_id updates on update", %{
    book_entry_data: book_entry_data
  } do
    %Books.BookEntry{id: new_id} = Helpers.create_book_entry!()
    Helpers.update_book_entry_data(book_entry_data, %{book_entry_id: new_id})

    %Books.BookEntryData{book_entry_id: id} =
      Repo.get(Books.BookEntryData, book_entry_data.id)

    assert id == new_id
  end

  test "book_entry_data value updates on update", %{
    book_entry_data: book_entry_data
  } do
    Helpers.update_book_entry_data(book_entry_data, %{
      value: %{"0" => "new data"}
    })

    %Books.BookEntryData{value: value} =
      Repo.get(Books.BookEntryData, book_entry_data.id)

    assert value == %{"0" => "new data"}
  end

  test "book_field name is required" do
    {success, _book_field} = Helpers.create_book_field(%{name: nil})
    assert success == :error
  end

  test "book_field book_group_id is required" do
    {success, _book_field} = Helpers.create_book_field(%{book_group_id: nil})
    assert success == :error
  end

  test "book_field type_id is required" do
    {success, _book_field} = Helpers.create_book_field(%{type_id: nil})
    assert success == :error
  end

  test "book_field desc is not required" do
    {success, _book_field} = Helpers.create_book_field(%{desc: nil})
    assert success == :ok
  end

  test "book_field name updates on update", %{book_field: book_field} do
    Helpers.update_book_field(book_field, %{name: "Brand new name"})
    %Books.BookField{name: name} = Repo.get(Books.BookField, book_field.id)
    assert name == "Brand new name"
  end

  test "book_field desc updates on update", %{book_field: book_field} do
    Helpers.update_book_field(book_field, %{desc: "Brand new desc"})
    %Books.BookField{desc: desc} = Repo.get(Books.BookField, book_field.id)
    assert desc == "Brand new desc"
  end

  test "book_field type_id updates on update", %{book_field: book_field} do
    %Books.BookFieldType{id: new_id} = Helpers.create_book_field_type!()
    Helpers.update_book_field(book_field, %{type_id: new_id})
    %Books.BookField{type_id: id} = Repo.get(Books.BookField, book_field.id)
    assert id == new_id
  end

  test "book_field book_group_id updates on update", %{book_field: book_field} do
    %Books.BookGroup{id: new_id} = Helpers.create_book_group!()
    Helpers.update_book_field(book_field, %{book_group_id: new_id})

    %Books.BookField{book_group_id: id} =
      Repo.get(Books.BookField, book_field.id)

    assert id == new_id
  end

  test "book_field_type name is required" do
    {success, _book_field_type} = Helpers.create_book_field_type(%{name: nil})
    assert success == :error
  end

  test "book_field_type desc is not required" do
    {success, _book_field_type} = Helpers.create_book_field_type(%{desc: nil})
    assert success == :ok
  end

  test "book_field_type name updates on update", %{
    book_field_type: book_field_type
  } do
    Helpers.update_book_field_type(book_field_type, %{name: "A new name"})

    %Books.BookFieldType{name: name} =
      Repo.get(Books.BookFieldType, book_field_type.id)

    assert name == "A new name"
  end

  test "book_field_type desc updates on update", %{
    book_field_type: book_field_type
  } do
    Helpers.update_book_field_type(book_field_type, %{desc: "A new desc"})

    %Books.BookFieldType{desc: desc} =
      Repo.get(Books.BookFieldType, book_field_type.id)

    assert desc == "A new desc"
  end

  test "book_group name is required" do
    {success, _book_group} = Helpers.create_book_group(%{name: nil})
    assert success == :error
  end

  test "book_group book_id is required" do
    {success, _book_group} = Helpers.create_book_group(%{book_id: nil})
    assert success == :error
  end

  test "book_group name updates on update", %{book_group: book_group} do
    Helpers.update_book_group(book_group, %{name: "A new name"})
    %Books.BookGroup{name: name} = Repo.get(Books.BookGroup, book_group.id)
    assert name == "A new name"
  end

  test "book_group book_id updates on update", %{book_group: book_group} do
    %Books.Book{id: new_id} = Helpers.create_book!()
    Helpers.update_book_group(book_group, %{book_id: new_id})
    %Books.BookGroup{book_id: id} = Repo.get(Books.BookGroup, book_group.id)
    assert id == new_id
  end

  test "function get_book_entries_by_book/1 returns all book entries for a book" do
    book = Helpers.create_book!()

    book_entries = [
      Helpers.create_book_entry!(%{book_id: book.id}),
      Helpers.create_book_entry!(%{book_id: book.id}),
      Helpers.create_book_entry!(%{book_id: book.id})
    ]

    other_book_entry =
      Helpers.create_book_entry!(%{book_id: Helpers.create_book!().id})

    retrieved_book_entries = Books.get_book_entries_by_book(book)
    assert Enum.count(retrieved_book_entries) == Enum.count(book_entries)

    Enum.each(retrieved_book_entries, fn be ->
      assert Enum.member?(book_entries, be) && be != other_book_entry
    end)
  end

  test "function get_book_groups_by_book/1 returns all book groups for a book" do
    book = Helpers.create_book!()

    book_groups = [
      Helpers.create_book_group!(%{book_id: book.id}),
      Helpers.create_book_group!(%{book_id: book.id}),
      Helpers.create_book_group!(%{book_id: book.id})
    ]

    other_book_group =
      Helpers.create_book_group!(%{book_id: Helpers.create_book!().id})

    retrieved_book_groups = Books.get_book_groups_by_book(book)
    assert Enum.count(retrieved_book_groups) == Enum.count(book_groups)

    Enum.each(retrieved_book_groups, fn bg ->
      assert Enum.member?(book_groups, bg) && bg != other_book_group
    end)
  end

  test "function get_book_fields_by_group/1 returns all book fields for a book group" do
    book_group = Helpers.create_book_group!()

    book_fields = [
      Helpers.create_book_field!(%{book_group_id: book_group.id}),
      Helpers.create_book_field!(%{book_group_id: book_group.id}),
      Helpers.create_book_field!(%{book_group_id: book_group.id})
    ]

    other_book_field =
      Helpers.create_book_field!(%{
        book_group_id: Helpers.create_book_group!().id
      })

    retrieved_book_fields = Books.get_book_fields_by_group(book_group)
    assert Enum.count(retrieved_book_fields) == Enum.count(book_fields)

    Enum.each(retrieved_book_fields, fn bf ->
      assert Enum.member?(book_fields, bf) && bf != other_book_field
    end)
  end

  test "function get_book_entry_data_field_type/1 returns the proper field type for a book entry data" do
    type = Helpers.create_book_field_type!(%{name: "another float"})

    %Books.BookField{id: book_field_id} =
      Helpers.create_book_field!(%{type_id: type.id})

    book_entry_data =
      Helpers.create_book_entry_data!(%{book_field_id: book_field_id})

    Helpers.create_book_field_type!()
    Helpers.create_book_field_type!()
    Helpers.create_book_field_type!()

    retrieved_type = Books.get_book_entry_data_field_type(book_entry_data)
    assert retrieved_type == type
  end
end
