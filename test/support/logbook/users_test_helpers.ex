defmodule Logbook.UsersTestHelpers do
  @moduledoc """
  Test helpers for users
  """

  alias Logbook.Users
  alias Logbook.{AircraftTestHelpers, AirportsTestHelpers, BooksTestHelpers}

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
