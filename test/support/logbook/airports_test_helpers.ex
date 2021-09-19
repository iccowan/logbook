defmodule Logbook.AirportsTestHelpers do
  @moduledoc """
  Test helpers for airports
  """

  alias Logbook.Airports
  alias Logbook.{UsersTestHelpers}

  defdelegate create_user(overrides \\ %{}), to: UsersTestHelpers
  defdelegate create_user!(overrides \\ %{}), to: UsersTestHelpers

  def create_airport(overrides \\ %{}) do
    %{
      code: "KGMU",
      name: "Greenville Downtown Airport",
      location: "Greenville, SC",
      is_favorite: false,
      user_id: create_user!().id
    }
    |> Map.merge(overrides)
    |> Airports.create_airport()
  end

  def create_airport!(overrides \\ %{}) do
    create_airport(overrides)
    |> elem(1)
  end

  def update_airport(airport, overrides \\ %{}) do
    Airports.update_airport(airport, overrides)
  end

  def update_airport!(airport, overrides \\ %{}) do
    update_airport(airport, overrides)
    |> elem(1)
  end
end
