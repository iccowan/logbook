defmodule Logbook.Airports do
  @moduledoc """
  Airports context
  """

  import Ecto.Query, warn: false

  alias Logbook.Airports
  alias Logbook.Repo

  @spec create_airport(map()) :: Airports.Airport.t()
  def create_airport(attrs \\ %{}) do
    %Airports.Airport{}
    |> Airports.Airport.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_airport(Airports.Airport.t(), map()) :: Airports.Airport.t()
  def update_airport(airport = %Airports.Airport{}, attrs \\ %{}) do
    airport
    |> Airports.Airport.changeset(attrs)
    |> Repo.update()
  end
end
