defmodule Logbook.Users do
  @moduledoc """
  Users context
  """

  import Ecto.Query, warn: false

  alias Logbook.Users
  alias Logbook.Repo

  @spec create_user(map()) :: Users.User.t()
  def create_user(attrs \\ %{}) do
    %Users.User{}
    |> Users.User.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_user(Users.User.t(), map()) :: Users.User.t()
  def update_user(user = %Users.User{}, attrs \\ %{}) do
    user
    |> Users.User.changeset(attrs)
    |> Repo.update()
  end
end
