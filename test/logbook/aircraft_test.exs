defmodule Logbook.AircraftTest do
  use Logbook.DataCase, async: true
  doctest Logbook.Aircraft

  alias Logbook.Aircraft
  alias Logbook.AircraftTestHelpers, as: Helpers
end
