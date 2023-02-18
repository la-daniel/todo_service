defmodule TodoApi.ListPermission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "list_permissions" do

    field :user_id, :id
    field :list_id, :id

    timestamps()
  end

  @doc false
  def changeset(list_permission, attrs) do
    list_permission
    |> cast(attrs, [])
    |> validate_required([])
  end
end
