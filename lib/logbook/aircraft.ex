defmodule Logbook.Aircraft do
  @moduledoc """
  Aircraft context
  """

  import Ecto.Query, warn: false

  alias Logbook.Aircraft
  alias Logbook.Repo

  @spec create_aircraft(map()) :: Aircraft.Aircraft.t()
  def create_aircraft(attrs \\ %{}) do
    %Aircraft.Aircraft{}
    |> Aircraft.Aircraft.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_aircraft(Aircraft.Aircraft.t(), map()) :: Aircraft.Aircraft.t()
  def update_aircraft(aircraft = %Aircraft.Aircraft{}, attrs \\ %{}) do
    aircraft
    |> Aircraft.Aircraft.changeset(attrs)
    |> Repo.update()
  end

  @spec create_aircraft_type(map()) :: Aircraft.AircraftType.t()
  def create_aircraft_type(attrs \\ %{}) do
    %Aircraft.AircraftType{}
    |> Aircraft.AircraftType.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_aircraft_type(Aircraft.AircraftType.t(), map()) ::
          Aircraft.AircraftType.t()
  def update_aircraft_type(
        aircraft_type = %Aircraft.AircraftType{},
        attrs \\ %{}
      ) do
    aircraft_type
    |> Aircraft.AircraftType.changeset(attrs)
    |> Repo.update()
  end

  @spec create_aircraft_class(map()) :: Aircraft.AircraftClass.t()
  def create_aircraft_class(attrs \\ %{}) do
    %Aircraft.AircraftClass{}
    |> Aircraft.AircraftClass.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_aircraft_class(Aircraft.AircraftClass.t(), map()) ::
          Aircraft.AircraftClass.t()
  def update_aircraft_class(
        aircraft_class = %Aircraft.AircraftClass{},
        attrs \\ %{}
      ) do
    aircraft_class
    |> Aircraft.AircraftClass.changeset(attrs)
    |> Repo.update()
  end

  @spec create_aircraft_category(map()) :: Aircraft.AircraftCategory.t()
  def create_aircraft_category(attrs \\ %{}) do
    %Aircraft.AircraftCategory{}
    |> Aircraft.AircraftCategory.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_aircraft_category(Aircraft.AircraftCategory.t(), map()) ::
          Aircraft.AircraftCategory.t()
  def update_aircraft_category(
        aircraft_category = %Aircraft.AircraftCategory{},
        attrs \\ %{}
      ) do
    aircraft_category
    |> Aircraft.AircraftCategory.changeset(attrs)
    |> Repo.update()
  end
end
