defmodule Logbook.Aircraft.AircraftClass do
  @moduledoc """
  AircraftClass schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Logbook.Aircraft.{AircraftClass, AircraftType, AircraftCategory}

  schema "aircraft_classes" do
    field :name, :string

    timestamps()

    belongs_to :aircraft_category, AircraftCategory,
      foreign_key: :aircraft_category_id,
      type: :integer

    has_many :aircraft_types, AircraftType
  end

  @type t :: %__MODULE__{
          id: integer(),
          name: String.t(),
          aircraft_category: AircraftCategory.t(),
          aircraft_category_id: integer(),
          aircraft_types: [AircraftType.t()],
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  def changeset(aircraft_class = %AircraftClass{}, attrs \\ %{}) do
    aircraft_class
    |> cast(attrs, [:name, :aircraft_category_id])
    |> validate_required([:name, :aircraft_category_id])
  end
end
