defmodule TodoApi.Todo.User do
  use Ecto.Schema
  import Ecto.Changeset

 @derive {Jason.Encoder, only: [:password, :username, :lists]} 
  schema "users" do
    field :password, :string, redact: true
    field :username, :string
    has_many :lists, TodoApi.Todo.List  # this was added
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> cast_assoc(:lists)
  end
end
