defmodule Logbook.Users do
  @moduledoc """
  Users context
  """

  import Ecto.Query, warn: false

  alias Logbook.{Aircraft, Books, Users}
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

  @spec get_books_by_user(Users.User.t()) :: [Books.Book.t()]
  def get_books_by_user(_user = %Users.User{id: user_id}) do
    Repo.all(
      from b in Books.Book,
        where: b.user_id == ^user_id
    )
  end

  @spec get_aircraft_by_user(Users.User.t()) :: [Aircraft.Aircraft.t()]
  def get_aircraft_by_user(_user = %Users.User{id: user_id}) do
    Repo.all(
      from ac in Aircraft.Aircraft,
        join: at in Aircraft.AircraftType,
        on: ac.aircraft_type_id == at.id,
        where: at.user_id == ^user_id
    )
  end
end
