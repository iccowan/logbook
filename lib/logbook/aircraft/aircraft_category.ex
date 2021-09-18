defmodule Logbook.Aircraft.AircraftCategory do
  @moduledoc """
  AircraftCategory schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Logbook.Aircraft.AircraftClass

  schema "aircraft_category" do
    field :name, :string

    timestamps()

    has_many :aircraft_classes, AircraftClass
  end
end
