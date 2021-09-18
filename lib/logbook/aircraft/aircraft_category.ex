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

  @type t :: %__MODULE__{
          id: Integer.t(),
          name: String.t(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }
end
