defmodule Logbook.Aircraft.AircraftType do
  @moduledoc """
  AircraftType schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Logbook.Users.User
  alias Logbook.Aircraft.{Aircraft, AircraftClass, AircraftType}

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "aircraft_types" do
    field :name, :string
    field :make, :string
    field :model, :string
    field :engine, :string
    field :complex, :boolean
    field :high_performance, :boolean
    field :high_altitude, :boolean
    field :tailwheel, :boolean

    timestamps()

    belongs_to :user, User, foreign_key: :user_id, type: :binary_id

    belongs_to :aircraft_class, AircraftClass,
      foreign_key: :aircraft_class_id,
      type: :integer

    has_many :aircraft, Aircraft
  end

  @type t :: %__MODULE__{
          id: Ecto.UUID.t(),
          name: String.t(),
          make: String.t(),
          model: String.t(),
          engine: String.t(),
          complex: boolean(),
          high_performance: boolean(),
          high_altitude: boolean(),
          tailwheel: boolean(),
          user: User.t(),
          user_id: Ecto.UUID.t(),
          aircraft_class: AircraftClass.t(),
          aircraft_class_id: integer(),
          aircraft: [Aircraft.t()],
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  def changeset(aircraft_type = %AircraftType{}, attrs \\ %{}) do
    aircraft_type
    |> cast(attrs, [
      :name,
      :make,
      :model,
      :engine,
      :complex,
      :high_performance,
      :high_altitude,
      :tailwheel,
      :user_id,
      :aircraft_class_id
    ])
    |> validate_required([:name, :user_id])
  end
end
