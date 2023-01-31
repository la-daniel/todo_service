defmodule TodoApiWeb.Todo do
  use TodoApiWeb, :live_view
  require Logger
  require Phoenix.Component
  alias TodoApi.User
  # use Phoenix.LiveView
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
    |> assign(:todos, User.list_todos)
  end

  def assign_todo(socket) do
    socket
    |> assign(:todo, %User.Todo{})
  end

  def assign_changeset(socket) do
    assign(socket, %{changeset: User.change_todo(%User.Todo{}) })
  end


  def handle_event("delete", params, socket) do
    Logger.info(params["todo"])
    del_todo = User.get_todo!(params["todo"])
    User.delete_todo(del_todo)
    {:noreply, assign(socket,:todos, User.list_todos())}
  end


  def handle_event("validate", %{"todo" => params}, socket) do
    changeset =
      %User.Todo{}
      |> User.change_todo(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end


  def handle_event("edit",  %{"todo" => todo_params}, socket) do
      Logger.debug(todo_params)
      update_todo = User.get_todo!(todo_params["id"])
      User.update_todo(update_todo, todo_params)
      toggle_todo(String.to_integer(todo_params["id"]))
    {:noreply, assign(socket, :todos, User.list_todos())}
  end


  def handle_event("save", %{"todo" => todo_params}, socket) do
    User.create_todo(todo_params)
    {:noreply, assign(socket,:todos, User.list_todos())}
  end

  # def handle_event("inc", _, socket) do
  #   {:noreply, assign(socket, val: Count.incr())}
  # end

  # def handle_event( "toggle_edit", params, socket) do
  #   Logger.debug("#edit_" <> params["todo_id"])
  #   {:noreply, socket}

  #   # toggle_todo(params["todo_id"])

  # end

  def toggle_todo(id) do
    # Logger.info(id)
    %JS{}
    |> JS.toggle( to: "#view_"<>Integer.to_string(id))
    |> JS.toggle( to: "#edit_"<>Integer.to_string(id))
    # |> JS.hide( to: "#edit_"<>id)
    # |> JS.toggle( to: "#view_"<>id)
    # |> JS.add_class("TRAINS", to: "#view_1")
    # JS.toggle(js, to: "#hallo")
  end

  def render(assigns) do
    ~H"""
    <.form let={f} for={@changeset} phx-change="validate" phx-submit="save" class="flex flex-col" id="hallo">
      <%= label f, :title %>
      <%= text_input f, :title, class: "flex-auto"  %>
      <%= error_tag f, :title %>

      <%= label f, :detail %>
      <%= text_input f, :detail %>
      <%= error_tag f, :detail %>

      <%=  submit "Save" , class: "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" %>
    </.form>

    <hr class="mt-3">
      <%= for todo <- @todos do %>
        <div class="m-4" id={"view_#{todo.id}"} >
          <b><%= todo.title %></b>
          <br>
          <%= todo.detail %>
          <br>
          <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" phx-value-todo_id={ todo.id }
          phx-click={toggle_todo(todo.id)}>Edit</button>
          <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" phx-click="delete"
            phx-value-todo={ todo.id }> Delete Todo</button>
        </div>
        <div class="m-4" id={"edit_#{todo.id}"} style="display:none">
          <.form let={todo} for={User.change_todo(todo)} phx-change="validate" phx-submit="edit" class="flex flex-col" id="hallo_edit" phx-value-todo={todo.id}>

            <%= text_input todo, :id, style: "display:none"%>

            <%= label todo, :title %>
            <%= text_input todo, :title, class: "flex-auto"  %>
            <%= error_tag todo, :title %>

            <%= label todo, :detail %>
            <%= text_input todo, :detail %>
            <%= error_tag todo, :detail %>

            <div>
              <%=  submit "Save" , class: "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" %>
              </div>
          </.form>
              <button class="bg-orange-500 hover:bg-orange-700 text-white font-bold py-2 px-4 rounded" phx-click={toggle_todo(todo.id)}>Cancel</button>
        </div>
        <hr>
      <% end %>
    """
  end
end
