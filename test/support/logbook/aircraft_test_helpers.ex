defmodule Logbook.AircraftTestHelpers do
  @moduledoc """
  Test helpers for aircraft
  """

  alias Logbook.Aircraft
  alias Logbook.{AirportsTestHelpers, UsersTestHelpers}

  defdelegate create_airport(overrides \\ %{}), to: AirportsTestHelpers
  defdelegate create_airport!(overrides \\ %{}), to: AirportsTestHelpers

  defdelegate create_user(overrides \\ %{}), to: UsersTestHelpers
  defdelegate create_user!(overrides \\ %{}), to: UsersTestHelpers

  def create_aircraft(overrides \\ %{}) do
    %{
      tail_number: "N159FS",
      notes: "These are some notes",
      is_favorite: false,
      aircraft_type_id: create_aircraft_type!().id,
      home_base_apt_id: create_airport!().id
    }
    |> Map.merge(overrides)
    |> Aircraft.create_aircraft()
  end

  def create_aircraft!(overrides \\ %{}) do
    create_aircraft(overrides)
    |> elem(1)
  end

  def update_aircraft(aircraft, overrides \\ %{}) do
    Aircraft.update_aircraft(aircraft, overrides)
  end

  def update_aircraft!(aircraft, overrides \\ %{}) do
    update_aircraft(aircraft, overrides)
    |> elem(1)
  end

  def create_aircraft_type(overrides \\ %{}) do
    %{
      name: "C172R",
      make: "Cessna",
      model: "172-R",
      engine: "Lycoming IO-360-L2A",
      complex: false,
      high_performance: false,
      high_altitude: false,
      tailwheel: false,
      user_id: create_user!().id,
      aircraft_class_id: create_aircraft_class!().id
    }
    |> Map.merge(overrides)
    |> Aircraft.create_aircraft_type()
  end

  def create_aircraft_type!(overrides \\ %{}) do
    create_aircraft_type(overrides)
    |> elem(1)
  end

  def update_aircraft_type(aircraft_type, overrides \\ %{}) do
    Aircraft.update_aircraft_type(aircraft_type, overrides)
  end

  def update_aircraft_type!(aircraft_type, overrides \\ %{}) do
    update_aircraft_type(aircraft_type, overrides)
    |> elem(1)
  end

  def create_aircraft_class(overrides \\ %{}) do
    %{
      name: "Single Engine Land",
      aircraft_category_id: create_aircraft_category!().id
    }
    |> Map.merge(overrides)
    |> Aircraft.create_aircraft_class()
  end

  def create_aircraft_class!(overrides \\ %{}) do
    create_aircraft_class(overrides)
    |> elem(1)
  end

  def update_aircraft_class(aircraft_class, overrides \\ %{}) do
    Aircraft.update_aircraft_class(aircraft_class, overrides)
  end

  def update_aircraft_class!(aircraft_class, overrides \\ %{}) do
    update_aircraft_class(aircraft_class, overrides)
    |> elem(1)
  end

  def create_aircraft_category(overrides \\ %{}) do
    %{
      name: "Airplane"
    }
    |> Map.merge(overrides)
    |> Aircraft.create_aircraft_category()
  end

  def create_aircraft_category!(overrides \\ %{}) do
    create_aircraft_category(overrides)
    |> elem(1)
  end

  def update_aircraft_category(aircraft_category, overrides \\ %{}) do
    Aircraft.update_aircraft_category(aircraft_category, overrides)
  end

  def update_aircraft_category!(aircraft_category, overrides \\ %{}) do
    update_aircraft_category(aircraft_category, overrides)
    |> elem(1)
  end
end
