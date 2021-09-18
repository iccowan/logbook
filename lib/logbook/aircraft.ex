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
end
