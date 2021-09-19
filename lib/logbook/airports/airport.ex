defmodule Logbook.Airports.Airport do
  @moduledoc """
  Airport schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Logbook.Airports.Airport
  alias Logbook.Aircraft.Aircraft
  alias Logbook.Users.User
  alias Logbook.Books.BookEntry

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "airports" do
    field :code, :string
    field :name, :string
    field :location, :string
    field :is_favorite, :boolean

    timestamps()

    belongs_to :user, User, foreign_key: :user_id, type: :binary_id

    has_many :aircraft, Aircraft, foreign_key: :aircraft_type_id
    has_many :book_entries_dep, BookEntry, foreign_key: :apt_from_id
    has_many :book_entries_dest, BookEntry, foreign_key: :apt_to_id
  end

  @type t :: %__MODULE__{
          id: Ecto.UUID.t(),
          code: String.t(),
          name: String.t(),
          location: String.t(),
          is_favorite: boolean(),
          user: User.t(),
          user_id: Ecto.UUID.t(),
          aircraft: [Aircraft.t()],
          book_entries_dep: [BookEntry.t()],
          book_entries_dest: [BookEntry.t()],
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  def changeset(airport = %Airport{}, attrs \\ %{}) do
    airport
    |> cast(attrs, [:code, :name, :location, :is_favorite, :user_id])
    |> validate_required([:code, :name, :user_id])
  end
end
