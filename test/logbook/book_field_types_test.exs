defmodule Logbook.BookFieldTypesTest do
  use Logbook.DataCase, async: true
  doctest Logbook.Books

  alias Logbook.Books

  test "DB seeds the correct book field types and we can retrieve those fields" do
    Code.require_file("../../priv/repo/seeds.exs", __DIR__)

    fields = [
      %{desc: "Whole Integer Number", id: 0, name: "Integer"},
      %{desc: "Decimal Number", id: 1, name: "Decimal"},
      %{desc: "Short Text", id: 2, name: "Short Text"},
      %{desc: "Long Text", id: 3, name: "Long Text"}
    ]

    retrieved_fields = Books.get_book_field_types()
    assert Enum.count(fields) == Enum.count(retrieved_fields)

    Enum.each(retrieved_fields, fn f ->
      assert Enum.member?(fields, f)
    end)
  end
end
