defmodule TodoApiWeb.TodoController do
  use TodoApiWeb, :controller

  alias TodoApi.Users
  alias TodoApi.Users.Todo

  action_fallback TodoApiWeb.FallbackController

  def index(conn, _params) do
    todos = Users.list_todos()
    render(conn, "index.json", todos: todos)
  end

  def create(conn, %{"todo" => todo_params}) do
    with {:ok, %Todo{} = todo} <- Users.create_todo(todo_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.todo_path(conn, :show, todo))
      |> render("show.json", todo: todo)
    end
  end

  def show(conn, %{"id" => id}) do
    todo = Users.get_todo!(id)
    render(conn, "show.json", todo: todo)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    todo = Users.get_todo!(id)

    with {:ok, %Todo{} = todo} <- Users.update_todo(todo, todo_params) do
      render(conn, "show.json", todo: todo)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = Users.get_todo!(id)

    with {:ok, %Todo{}} <- Users.delete_todo(todo) do
      send_resp(conn, :no_content, "")
    end
  end
end
