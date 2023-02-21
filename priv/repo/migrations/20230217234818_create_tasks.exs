defmodule TodoApi.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :detail, :string
      add :title, :string
      add :order, :integer
      add :list_id, references(:lists, on_delete: :nothing)
      add :assigned_to, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:list_id])
    create index(:tasks, [:assigned_to])
  end
end
