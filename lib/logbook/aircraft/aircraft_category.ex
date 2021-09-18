defmodule Logbook.Aircraft.AircraftCategory do
  @moduledoc """
  AircraftCategory schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Logbook.Aircraft.{AircraftClass, AircraftCategory}

  schema "aircraft_category" do
    field :name, :string

    timestamps()

    has_many :aircraft_classes, AircraftClass
  end

  @type t :: %__MODULE__{
          id: integer(),
          name: String.t(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  def changeset(aircraft_category = %AircraftCategory{}, attrs \\ %{}) do
    aircraft_category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
