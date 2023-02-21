defmodule TodoApiWeb.UserView do
  use TodoApiWeb, :view
  alias TodoApiWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("index_all.json", %{users: users}) do
    %{data: render_many(users, UserView, "all_users.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      password: user.password
    }
  end

  def render("all_users.json", %{user: user}) do
    IO.inspect(user)
    %{
      id: user.id,
      username: user.username,
      password: user.password,
      lists: user.lists
    }
  end
end
