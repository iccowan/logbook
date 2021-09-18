defmodule Logbook.Aircraft.AircraftType do
  @moduledoc """
  AircraftType schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Logbook.Users.User
  alias Logbook.Aircraft.{Aircraft, AircraftClass}

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "aircraft_type" do
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
end
