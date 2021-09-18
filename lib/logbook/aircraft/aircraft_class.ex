defmodule Logbook.Aircraft.AircraftClass do
  @moduledoc """
  AircraftClass schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Logbook.Aircraft.{AircraftType, AircraftCategory}

  schema "aircraft_class" do
    field :name, :string

    timestamps()

    belongs_to :aircraft_category, AircraftCategory,
      foreign_key: :aircraft_category_id,
      type: :integer

    has_many :aircraft_types, AircraftType
  end
end
