defmodule TodoApi.TodoFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TodoApi.Todo` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        password: "some password",
        username: "some username"
      })
      |> TodoApi.Todo.create_user()

    user
  end

  @doc """
  Generate a list.
  """
  def list_fixture(attrs \\ %{}) do
    {:ok, list} =
      attrs
      |> Enum.into(%{
        order: 42,
        title: "some title"
      })
      |> TodoApi.Todo.create_list()

    list
  end

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        comment: "some comment",
        detail: "some detail",
        order: 42,
        title: "some title"
      })
      |> TodoApi.Todo.create_task()

    task
  end

  @doc """
  Generate a permission.
  """
  def permission_fixture(attrs \\ %{}) do
    {:ok, permission} =
      attrs
      |> Enum.into(%{

      })
      |> TodoApi.Todo.create_permission()

    permission
  end
end
