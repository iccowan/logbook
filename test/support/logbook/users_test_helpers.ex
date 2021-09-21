defmodule Logbook.UsersTestHelpers do
  @moduledoc """
  Test helpers for users
  """

  alias Logbook.Users
  alias Logbook.{AircraftTestHelpers, BooksTestHelpers}

  defdelegate create_book!(overrides \\ %{}), to: BooksTestHelpers
  defdelegate create_book(overrides \\ %{}), to: BooksTestHelpers

  defdelegate create_aircraft!(overrides \\ %{}), to: AircraftTestHelpers
  defdelegate create_aircraft(overrides \\ %{}), to: AircraftTestHelpers

  defdelegate create_aircraft_type!(overrides \\ %{}), to: AircraftTestHelpers
  defdelegate create_aircraft_type(overrides \\ %{}), to: AircraftTestHelpers

  def create_user(overrides \\ %{}) do
    %{
      first_name: "Firstname",
      last_name: "Lastname",
      email: "address@email.com"
    }
    |> Map.merge(overrides)
    |> Users.create_user()
  end

  def create_user!(overrides \\ %{}) do
    create_user(overrides)
    |> elem(1)
  end

  def update_user(user, overrides \\ %{}) do
    Users.update_user(user, overrides)
  end

  def update_user!(user, overrides \\ %{}) do
    update_user(user, overrides)
    |> elem(1)
  end
end
