defmodule Logbook.UsersTest do
  use Logbook.DataCase, async: true
  doctest Logbook.Users

  alias Logbook.Users
  alias Logbook.UsersTestHelpers, as: Helpers
end
