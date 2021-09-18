defmodule Logbook.BooksTest do
  use Logbook.DataCase, async: true
  doctest Logbook.Books

  alias Logbook.Books
  alias Logbook.BooksTestHelpers, as: Helpers
end
