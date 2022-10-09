defmodule TodoApi.User.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :details, :string
    field :order, :integer
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :details, :order])
    |> validate_required([:title, :details, :order])
  end
end
