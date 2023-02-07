defmodule TodoApiWeb.Todo do
  use TodoApiWeb, :live_view
  require Logger
  require Phoenix.Component
  alias TodoApi.Users
  alias Phoenix.LiveView.JS

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_todo()
     |> assign_todo_list()
     |> assign_changeset()
     |> assign_changeset_edit()
     |> assign_show_create()}
  end

  def assign_todo_list(socket) do
    socket
    |> assign(:todos, Users.list_todos())
  end

  def assign_todo(socket) do
    socket
    |> assign(:todo, %Users.Todo{})
  end

  def assign_show_create(socket) do
    socket
    |> assign(:showCreate, false)
  end

  def assign_changeset(socket) do
    assign(socket, %{changeset: Users.change_todo(%Users.Todo{})})
  end

  def assign_changeset_edit(socket) do
    assign(socket, %{changeset_edit: Users.change_todo(%Users.Todo{})})
  end

  def handle_event("delete", params, socket) do
    Logger.info(params["todo"])
    del_todo = Users.get_todo!(params["todo"])
    Users.delete_todo(del_todo)
    {:noreply, assign(socket, :todos, Users.list_todos())}
  end

  def handle_event("validate", %{"todo" => params}, socket) do
    changeset =
      %Users.Todo{}
      |> Users.change_todo(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("validate_edit", %{"todo" => params}, socket) do
    changeset =
      %Users.Todo{}
      |> Users.change_todo(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset_edit: changeset)}
  end

  def handle_event("edit", %{"todo" => todo_params}, socket) do
    update_todo = Users.get_todo!(todo_params["id"])
    Users.update_todo(update_todo, todo_params)
    # Ecto.Changeset.change(socket.assigns.changeset_edit, id: 0)
    assign(socket, %{changeset_edit: Users.change_todo(%Users.Todo{})})
    Logger.info(socket.assigns.changeset_edit)

    {:noreply,
     assign(socket, todos: Users.list_todos(), changeset_edit: Users.change_todo(%Users.Todo{}))}
  end

  def handle_event("move", todo_params, socket) do
    Logger.debug(todo_params)

    Users.change_todo_order(
      String.to_integer(todo_params["todo-id"], 10),
      String.to_integer(todo_params["move-to"], 10)
    )

    {:noreply, assign(socket, :todos, Users.list_todos())}
  end

  def handle_event("save", %{"todo" => todo_params}, socket) do
    Users.create_todo(todo_params)
    {:noreply, assign(socket, :todos, Users.list_todos())}
  end

  def handle_event("toggle_create", _params, socket) do
    {:noreply, assign(socket, :showCreate, !socket.assigns.showCreate)}
  end

  def handle_event("start_edit", todo_params, socket) do
    Logger.info(todo_params["todo_id"])
    todo = Users.get_todo!(todo_params["todo_id"])
    Logger.info(Users.change_todo(todo))
    {:noreply, assign(socket, %{changeset_edit: Users.change_todo(todo)})}
  end

  def handle_event("cancel_edit", _todo_params, socket) do
    {:noreply, assign(socket, %{changeset_edit: Users.change_todo(%Users.Todo{})})}
  end

end
