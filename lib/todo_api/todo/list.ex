defmodule TodoApi.Todo.List do
  use Ecto.Schema
  import Ecto.Changeset

 @derive {Jason.Encoder, only: [:order, :title, :id, :tasks]} 
  schema "lists" do
    field :order, :integer
    field :title, :string
    field :assigned_to, :id
    belongs_to :user, TodoApi.Todo.User  # this was added
    has_many :tasks, TodoApi.Todo.Task 
    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:order, :title])
    |> validate_required([:order, :title])
    |> cast_assoc(:tasks)
  end
end
