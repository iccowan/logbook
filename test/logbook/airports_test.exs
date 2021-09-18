defmodule Logbook.AirportsTest do
  use Logbook.DataCase, async: true
  doctest Logbook.Airports

  alias Logbook.{Airports, Users}
  alias Logbook.AirportsTestHelpers, as: Helpers

  setup do
    %Users.User{id: user_id} = Helpers.create_user!()
    airport = Helpers.create_airport!(%{user_id: user_id})

    {
      :ok,
      airport: airport
    }
  end

  test "creating a new airport creates the airport", %{airport: airport} do
    assert Repo.exists?(from a in Airports.Airport, where: a.id == ^airport.id)
  end

  test "airport code required" do
    {status, _airport} = Helpers.create_airport(%{code: nil})
    assert status == :error
  end

  test "airport name required" do
    {status, _airport} = Helpers.create_airport(%{name: nil})
    assert status == :error
  end

  test "airport user_id required" do
    {status, _airport} = Helpers.create_airport(%{user_id: nil})
    assert status == :error
  end

  test "airport location not required" do
    {status, _airport} = Helpers.create_airport(%{location: nil})
    assert status == :ok
  end

  test "airport is_favorite not required" do
    {status, _airport} = Helpers.create_airport(%{is_favorite: nil})
    assert status == :ok
  end

  test "airport is_favorite defaults to false" do
    %Airports.Airport{id: airport_id} =
      Helpers.create_airport!(%{is_favorite: nil})

    %Airports.Airport{is_favorite: fav} = Repo.get(Airports.Airport, airport_id)
    assert fav == false
  end

  test "airport code updated on update", %{airport: airport} do
    Helpers.update_airport(airport, %{code: "KDVK"})
    %Airports.Airport{code: code} = Repo.get(Airports.Airport, airport.id)
    assert code == "KDVK"
  end

  test "airport name updated on update", %{airport: airport} do
    Helpers.update_airport(airport, %{name: "Danville Boyle"})
    %Airports.Airport{name: name} = Repo.get(Airports.Airport, airport.id)
    assert name == "Danville Boyle"
  end

  test "airport location updated on update", %{airport: airport} do
    Helpers.update_airport(airport, %{location: "Danville, KY"})

    %Airports.Airport{location: location} =
      Repo.get(Airports.Airport, airport.id)

    assert location == "Danville, KY"
  end

  test "airport is_favorite updated on update", %{airport: airport} do
    Helpers.update_airport(airport, %{is_favorite: true})

    %Airports.Airport{is_favorite: is_favorite} =
      Repo.get(Airports.Airport, airport.id)

    assert is_favorite == true
  end

  test "airport user_id updated on update", %{airport: airport} do
    %Users.User{id: user_id} = Helpers.create_user!()
    Helpers.update_airport(airport, %{user_id: user_id})

    %Airports.Airport{user_id: new_user_id} =
      Repo.get(Airports.Airport, airport.id)

    assert user_id == new_user_id
  end
end
