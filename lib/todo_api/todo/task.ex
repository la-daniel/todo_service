defmodule TodoApi.Todo.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :comment, :string
    field :detail, :string
    field :order, :integer
    field :title, :string
    field :list_id, :id
    field :assigned_to, :id

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:detail, :title, :order, :comment])
    |> validate_required([:detail, :title, :order, :comment])
  end
end
