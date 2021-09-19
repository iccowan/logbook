defmodule Logbook.AircraftTest do
  use Logbook.DataCase, async: true
  doctest Logbook.Aircraft

  alias Logbook.{Airports, Aircraft, Users}
  alias Logbook.AircraftTestHelpers, as: Helpers

  setup do
    aircraft_category = Helpers.create_aircraft_category!()

    aircraft_class =
      Helpers.create_aircraft_class!(%{
        aircraft_category_id: aircraft_category.id
      })

    user = Helpers.create_user!()

    aircraft_type =
      Helpers.create_aircraft_type!(%{
        aircraft_class_id: aircraft_class.id,
        user_id: user.id
      })

    aircraft = Helpers.create_aircraft!(%{aircraft_type_id: aircraft_type.id})

    {
      :ok,
      aircraft_category: aircraft_category,
      aircraft_class: aircraft_class,
      aircraft_type: aircraft_type,
      user: user,
      aircraft: aircraft
    }
  end

  test "creating a new aircraft_category creates the aircraft_category", %{
    aircraft_category: aircraft_category
  } do
    Repo.exists?(
      from a in Aircraft.AircraftCategory, where: a.id == ^aircraft_category.id
    )
  end

  test "creating a new aircraft_class creates the aircraft_class", %{
    aircraft_class: aircraft_class
  } do
    Repo.exists?(
      from a in Aircraft.AircraftClass, where: a.id == ^aircraft_class.id
    )
  end

  test "creating a new aircraft_type creates the aircraft_type", %{
    aircraft_type: aircraft_type
  } do
    Repo.exists?(
      from a in Aircraft.AircraftType, where: a.id == ^aircraft_type.id
    )
  end

  test "creating a new aircraft creates the aircraft", %{aircraft: aircraft} do
    Repo.exists?(from a in Aircraft.Aircraft, where: a.id == ^aircraft.id)
  end

  test "aircraft_category name required" do
    {status, _aircraft_category} =
      Helpers.create_aircraft_category(%{name: nil})

    assert status == :error
  end

  test "aircraft_class name required" do
    {status, _aircraft_class} = Helpers.create_aircraft_class(%{name: nil})
    assert status == :error
  end

  test "aircraft_class aircraft_category_id required" do
    {status, _aircraft_class} =
      Helpers.create_aircraft_class(%{aircraft_category_id: nil})

    assert status == :error
  end

  test "aircraft_type name required" do
    {status, _aircraft_type} = Helpers.create_aircraft_type(%{name: nil})
    assert status == :error
  end

  test "aircraft_type user_id required" do
    {status, _aircraft_type} = Helpers.create_aircraft_type(%{user_id: nil})
    assert status == :error
  end

  test "aircraft_type make not required" do
    {status, _aircraft_type} = Helpers.create_aircraft_type(%{make: nil})
    assert status == :ok
  end

  test "aircraft_type model not required" do
    {status, _aircraft_type} = Helpers.create_aircraft_type(%{model: nil})
    assert status == :ok
  end

  test "aircraft_type engine not required" do
    {status, _aircraft_type} = Helpers.create_aircraft_type(%{engine: nil})
    assert status == :ok
  end

  test "aircraft_type complex not required" do
    {status, _aircraft_type} = Helpers.create_aircraft_type(%{complex: nil})
    assert status == :ok
  end

  test "aircraft_type complex defaults to false" do
    %Aircraft.AircraftType{id: aircraft_type_id} =
      Helpers.create_aircraft_type!(%{complex: nil})

    %Aircraft.AircraftType{complex: is_complex} =
      Repo.get(Aircraft.AircraftType, aircraft_type_id)

    assert is_complex == false
  end

  test "aircraft_type high_performance not required" do
    {status, _aircraft_type} =
      Helpers.create_aircraft_type(%{high_performance: nil})

    assert status == :ok
  end

  test "aircraft_type high_performance defaults to false" do
    %Aircraft.AircraftType{id: aircraft_type_id} =
      Helpers.create_aircraft_type!(%{high_performance: nil})

    %Aircraft.AircraftType{high_performance: is_hp} =
      Repo.get(Aircraft.AircraftType, aircraft_type_id)

    assert is_hp == false
  end

  test "aircraft_type high_altitude not required" do
    {status, _aircraft_type} =
      Helpers.create_aircraft_type(%{high_altitude: nil})

    assert status == :ok
  end

  test "aircraft_type high_altitude defaults to false" do
    %Aircraft.AircraftType{id: aircraft_type_id} =
      Helpers.create_aircraft_type!(%{high_altitude: nil})

    %Aircraft.AircraftType{complex: is_ha} =
      Repo.get(Aircraft.AircraftType, aircraft_type_id)

    assert is_ha == false
  end

  test "aircraft_type tailwheel not required" do
    {status, _aircraft_type} = Helpers.create_aircraft_type(%{tailwheel: nil})
    assert status == :ok
  end

  test "aircraft_type tailwheel defaults to false" do
    %Aircraft.AircraftType{id: aircraft_type_id} =
      Helpers.create_aircraft_type!(%{tailwheel: nil})

    %Aircraft.AircraftType{complex: is_tailwheel} =
      Repo.get(Aircraft.AircraftType, aircraft_type_id)

    assert is_tailwheel == false
  end

  test "aircraft aircraft_class_id not required" do
    {status, _aircraft_type} =
      Helpers.create_aircraft_type(%{aircraft_class_id: nil})

    assert status == :ok
  end

  test "aircraft tail_number required" do
    {status, _aircraft} = Helpers.create_aircraft(%{tail_number: nil})
    assert status == :error
  end

  test "aircraft aircraft_type_id required" do
    {status, _aircraft} = Helpers.create_aircraft(%{aircraft_type_id: nil})
    assert status == :error
  end

  test "aircraft notes not required" do
    {status, _aircraft} = Helpers.create_aircraft(%{notes: nil})
    assert status == :ok
  end

  test "aircraft is_favorite not required" do
    {status, _aircraft} = Helpers.create_aircraft(%{is_favorite: nil})
    assert status == :ok
  end

  test "aircraft is_favorite defaults to false" do
    %Aircraft.Aircraft{id: aircraft_id} =
      Helpers.create_aircraft!(%{is_favorite: nil})

    %Aircraft.Aircraft{is_favorite: is_favorite} =
      Repo.get(Aircraft.Aircraft, aircraft_id)

    assert is_favorite == false
  end

  test "aircraft home_base_apt_id not required" do
    {status, _aircraft} = Helpers.create_aircraft(%{home_base_apt_id: nil})
    assert status == :ok
  end

  test "aircraft_category name updated on update", %{
    aircraft_category: aircraft_category
  } do
    %Aircraft.AircraftCategory{id: ac_id} =
      Helpers.update_aircraft_category!(aircraft_category, %{name: "Rotorcraft"})

    %Aircraft.AircraftCategory{name: name} =
      Repo.get(Aircraft.AircraftCategory, ac_id)

    assert name == "Rotorcraft"
  end

  test "aircraft_class name updated on update", %{
    aircraft_class: aircraft_class
  } do
    %Aircraft.AircraftClass{id: ac_id} =
      Helpers.update_aircraft_class!(aircraft_class, %{name: "Helicopter"})

    %Aircraft.AircraftClass{name: name} =
      Repo.get(Aircraft.AircraftClass, ac_id)

    assert name == "Helicopter"
  end

  test "aircraft_class aircraft_category_id updated on update", %{
    aircraft_class: aircraft_class
  } do
    %Aircraft.AircraftCategory{id: new_id} = Helpers.create_aircraft_category!()

    %Aircraft.AircraftClass{id: ac_id} =
      Helpers.update_aircraft_class!(aircraft_class, %{
        aircraft_category_id: new_id
      })

    %Aircraft.AircraftClass{aircraft_category_id: id} =
      Repo.get(Aircraft.AircraftClass, ac_id)

    assert new_id == id
  end

  test "aircraft_type name updated on update", %{aircraft_type: aircraft_type} do
    %Aircraft.AircraftType{id: ac_id} =
      Helpers.update_aircraft_type!(aircraft_type, %{name: "PA28"})

    %Aircraft.AircraftType{name: name} = Repo.get(Aircraft.AircraftType, ac_id)
    assert name == "PA28"
  end

  test "aircraft_type make updated on update", %{aircraft_type: aircraft_type} do
    %Aircraft.AircraftType{id: ac_id} =
      Helpers.update_aircraft_type!(aircraft_type, %{make: "Piper"})

    %Aircraft.AircraftType{make: make} = Repo.get(Aircraft.AircraftType, ac_id)
    assert make == "Piper"
  end

  test "aircraft_type model updated on update", %{aircraft_type: aircraft_type} do
    %Aircraft.AircraftType{id: ac_id} =
      Helpers.update_aircraft_type!(aircraft_type, %{model: "Arrow"})

    %Aircraft.AircraftType{model: model} =
      Repo.get(Aircraft.AircraftType, ac_id)

    assert model == "Arrow"
  end

  test "aircraft_type engine updated on update", %{aircraft_type: aircraft_type} do
    %Aircraft.AircraftType{id: ac_id} =
      Helpers.update_aircraft_type!(aircraft_type, %{engine: "IO-360-NOTL2A"})

    %Aircraft.AircraftType{engine: engine} =
      Repo.get(Aircraft.AircraftType, ac_id)

    assert engine == "IO-360-NOTL2A"
  end

  test "aircraft_type complex updated on update", %{
    aircraft_type: aircraft_type
  } do
    %Aircraft.AircraftType{id: ac_id} =
      Helpers.update_aircraft_type!(aircraft_type, %{complex: true})

    %Aircraft.AircraftType{complex: complex} =
      Repo.get(Aircraft.AircraftType, ac_id)

    assert complex == true
  end

  test "aircraft_type high_performance updated on update", %{
    aircraft_type: aircraft_type
  } do
    %Aircraft.AircraftType{id: ac_id} =
      Helpers.update_aircraft_type!(aircraft_type, %{high_performance: true})

    %Aircraft.AircraftType{high_performance: high_performance} =
      Repo.get(Aircraft.AircraftType, ac_id)

    assert high_performance == true
  end

  test "aircraft_type high_altitude updated on update", %{
    aircraft_type: aircraft_type
  } do
    %Aircraft.AircraftType{id: ac_id} =
      Helpers.update_aircraft_type!(aircraft_type, %{high_altitude: true})

    %Aircraft.AircraftType{high_altitude: high_altitude} =
      Repo.get(Aircraft.AircraftType, ac_id)

    assert high_altitude == true
  end

  test "aircraft_type tailwheel updated on update", %{
    aircraft_type: aircraft_type
  } do
    %Aircraft.AircraftType{id: ac_id} =
      Helpers.update_aircraft_type!(aircraft_type, %{tailwheel: true})

    %Aircraft.AircraftType{tailwheel: tailwheel} =
      Repo.get(Aircraft.AircraftType, ac_id)

    assert tailwheel == true
  end

  test "aircraft_type user_id updated on update", %{
    aircraft_type: aircraft_type
  } do
    %Users.User{id: user_id} = Helpers.create_user!()

    %Aircraft.AircraftType{id: ac_id} =
      Helpers.update_aircraft_type!(aircraft_type, %{user_id: user_id})

    %Aircraft.AircraftType{user_id: new_user_id} =
      Repo.get(Aircraft.AircraftType, ac_id)

    assert new_user_id == user_id
  end

  test "aircraft_type aircraft_class_id updated on update", %{
    aircraft_type: aircraft_type
  } do
    %Aircraft.AircraftClass{id: aircraft_class_id} =
      Helpers.create_aircraft_class!()

    %Aircraft.AircraftType{id: ac_id} =
      Helpers.update_aircraft_type!(aircraft_type, %{
        aircraft_class_id: aircraft_class_id
      })

    %Aircraft.AircraftType{aircraft_class_id: new_id} =
      Repo.get(Aircraft.AircraftType, ac_id)

    assert new_id == aircraft_class_id
  end

  test "aircraft tail_number updated on update", %{aircraft: aircraft} do
    %Aircraft.Aircraft{id: ac_id} = Helpers.update_aircraft!(aircraft, %{tail_number: "N16554"})
    %Aircraft.Aircraft{tail_number: tail_number} = Repo.get(Aircraft.Aircraft, ac_id)
    assert tail_number == "N16554"
  end

  test "aircraft notes updated on update", %{aircraft: aircraft} do
    %Aircraft.Aircraft{id: ac_id} = Helpers.update_aircraft!(aircraft, %{notes: "Maybe we decided to add some notes..."})
    %Aircraft.Aircraft{notes: notes} = Repo.get(Aircraft.Aircraft, ac_id)
    assert notes == "Maybe we decided to add some notes..."
  end

  test "aircraft is_favorite updated on update", %{aircraft: aircraft} do
    %Aircraft.Aircraft{id: ac_id} = Helpers.update_aircraft!(aircraft, %{is_favorite: true})
    %Aircraft.Aircraft{is_favorite: is_favorite} = Repo.get(Aircraft.Aircraft, ac_id)
    assert is_favorite == true
  end

  test "aircraft aircraft_type_id updated on update", %{aircraft: aircraft} do
    %Aircraft.AircraftType{id: new_id} = Helpers.create_aircraft_type!()
    %Aircraft.Aircraft{id: ac_id} = Helpers.update_aircraft!(aircraft, %{aircraft_type_id: new_id})
    %Aircraft.Aircraft{aircraft_type_id: id} = Repo.get(Aircraft.Aircraft, ac_id)
    assert id == new_id
  end

  test "aircraft home_base_apt_id updated on update", %{aircraft: aircraft} do
    %Airports.Airport{id: new_id} = Helpers.create_airport!()
    %Aircraft.Aircraft{id: ac_id} = Helpers.update_aircraft!(aircraft, %{home_base_apt_id: new_id})
    %Aircraft.Aircraft{home_base_apt_id: id} = Repo.get(Aircraft.Aircraft, ac_id)
    assert id == new_id
  end
end
