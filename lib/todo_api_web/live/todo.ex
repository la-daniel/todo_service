defmodule TodoApiWeb.Todo do
  use TodoApiWeb, :live_view
  require Logger
  require Phoenix.Component
  alias TodoApi.Users
  alias TodoApi.User
  alias Phoenix.LiveView.JS


  def mount(_params, _session, socket) do
    {:ok,
    socket
    |> assign_todo()
    |> assign_todo_list()
    |> assign_changeset() }
  end

  def assign_todo_list(socket) do
    socket
    |> assign(:todos, Users.list_todos)
  end

  def assign_todo(socket) do
    socket
    |> assign(:todo, %Users.Todo{})
  end

  def assign_changeset(socket) do
    assign(socket, %{changeset: Users.change_todo(%Users.Todo{}) })
  end


  def handle_event("delete", params, socket) do
    Logger.info(params["todo"])
    del_todo = Users.get_todo!(params["todo"])
    Users.delete_todo(del_todo)
    {:noreply, assign(socket,:todos, Users.list_todos())}
  end


  def handle_event("validate", %{"todo" => params}, socket) do
    changeset =
      %Users.Todo{}
      |> Users.change_todo(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end


  def handle_event("edit",  %{"todo" => todo_params}, socket) do
      Logger.debug(todo_params)
      update_todo = Users.get_todo!(todo_params["id"])
      Users.update_todo(update_todo, todo_params)
      toggle_todo(String.to_integer(todo_params["id"]))
    {:noreply, assign(socket, :todos, Users.list_todos())}
  end


  def handle_event("save", %{"todo" => todo_params}, socket) do
    Users.create_todo(todo_params)
    {:noreply, assign(socket,:todos, Users.list_todos())}
  end


  def toggle_todo(id) do
    # Logger.info(id)
    %JS{}
    |> JS.toggle( to: "#view_"<>Integer.to_string(id))
    |> JS.toggle( to: "#edit_"<>Integer.to_string(id))
  end

end
