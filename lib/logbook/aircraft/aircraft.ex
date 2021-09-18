defmodule Logbook.Aircraft.Aircraft do
  @moduledoc """
  Aircraft schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Logbook.Aircraft.{Aircraft, AircraftType}
  alias Logbook.Airports.Airport
  alias Logbook.Books.BookEntry

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "aircraft" do
    field :tail_number, :string
    field :notes, :string
    field :is_favorite, :boolean

    timestamps()

    belongs_to :aircraft_type, AircraftType,
      foreign_key: :aircraft_type_id,
      type: :binary_id

    belongs_to :home_base_airport, Airport,
      foreign_key: :home_base_apt_id,
      type: :binary_id

    has_many :book_entries, BookEntry
  end

  @type t :: %__MODULE__{
          id: Ecto.UUID.t(),
          tail_number: String.t(),
          notes: String.t(),
          is_favorite: boolean(),
          aircraft_type: AircraftType.t(),
          aircraft_type_id: Ecto.UUID.t(),
          home_base_airport: Airport.t(),
          home_base_apt_id: Ecto.UUID.t(),
          book_entries: [BookEntry.t()],
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  def changeset(aircraft = %Aircraft{}, attrs \\ %{}) do
    aircraft
    |> cast(attrs, [
      :tail_number,
      :notes,
      :is_favorite,
      :aircraft_type_id,
      :home_base_apt_id
    ])
    |> validate_required([:tail_number, :aircraft_type_id])
  end
end
