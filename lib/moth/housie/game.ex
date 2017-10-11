defmodule Moth.Housie.Game do
  use Ecto.Schema
  import Ecto.Changeset
  alias Moth.Housie.{Game, Prize}
  alias Moth.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "games" do
    field         :name,        :string
    belongs_to    :owner,       User
    has_many      :prizes,      Prize
    many_to_many  :moderators,  User,         join_through: :game_moderators
    
    embeds_one    :details,     GameDetail do
      field :interval, :integer, default: 45
      field :bulletin, :string
    end

    timestamps()
  end

  @doc false
  def changeset(%Game{} = game, attrs) do
    game
    |> cast(attrs, [])
    |> validate_required([])
  end
end
