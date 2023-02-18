defmodule TodoApi.TodoTest do
  use TodoApi.DataCase

  alias TodoApi.Todo

  describe "users" do
    alias TodoApi.Todo.User

    import TodoApi.TodoFixtures

    @invalid_attrs %{password: nil, username: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Todo.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Todo.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{password: "some password", username: "some username"}

      assert {:ok, %User{} = user} = Todo.create_user(valid_attrs)
      assert user.password == "some password"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{password: "some updated password", username: "some updated username"}

      assert {:ok, %User{} = user} = Todo.update_user(user, update_attrs)
      assert user.password == "some updated password"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_user(user, @invalid_attrs)
      assert user == Todo.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Todo.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Todo.change_user(user)
    end
  end

  describe "lists" do
    alias TodoApi.Todo.List

    import TodoApi.TodoFixtures

    @invalid_attrs %{order: nil, title: nil}

    test "list_lists/0 returns all lists" do
      list = list_fixture()
      assert Todo.list_lists() == [list]
    end

    test "get_list!/1 returns the list with given id" do
      list = list_fixture()
      assert Todo.get_list!(list.id) == list
    end

    test "create_list/1 with valid data creates a list" do
      valid_attrs = %{order: 42, title: "some title"}

      assert {:ok, %List{} = list} = Todo.create_list(valid_attrs)
      assert list.order == 42
      assert list.title == "some title"
    end

    test "create_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_list(@invalid_attrs)
    end

    test "update_list/2 with valid data updates the list" do
      list = list_fixture()
      update_attrs = %{order: 43, title: "some updated title"}

      assert {:ok, %List{} = list} = Todo.update_list(list, update_attrs)
      assert list.order == 43
      assert list.title == "some updated title"
    end

    test "update_list/2 with invalid data returns error changeset" do
      list = list_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_list(list, @invalid_attrs)
      assert list == Todo.get_list!(list.id)
    end

    test "delete_list/1 deletes the list" do
      list = list_fixture()
      assert {:ok, %List{}} = Todo.delete_list(list)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_list!(list.id) end
    end

    test "change_list/1 returns a list changeset" do
      list = list_fixture()
      assert %Ecto.Changeset{} = Todo.change_list(list)
    end
  end

  describe "tasks" do
    alias TodoApi.Todo.Task

    import TodoApi.TodoFixtures

    @invalid_attrs %{comment: nil, detail: nil, order: nil, title: nil}

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Todo.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Todo.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      valid_attrs = %{comment: "some comment", detail: "some detail", order: 42, title: "some title"}

      assert {:ok, %Task{} = task} = Todo.create_task(valid_attrs)
      assert task.comment == "some comment"
      assert task.detail == "some detail"
      assert task.order == 42
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      update_attrs = %{comment: "some updated comment", detail: "some updated detail", order: 43, title: "some updated title"}

      assert {:ok, %Task{} = task} = Todo.update_task(task, update_attrs)
      assert task.comment == "some updated comment"
      assert task.detail == "some updated detail"
      assert task.order == 43
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_task(task, @invalid_attrs)
      assert task == Todo.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Todo.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Todo.change_task(task)
    end
  end

  describe "permissions" do
    alias TodoApi.Todo.Permission

    import TodoApi.TodoFixtures

    @invalid_attrs %{}

    test "list_permissions/0 returns all permissions" do
      permission = permission_fixture()
      assert Todo.list_permissions() == [permission]
    end

    test "get_permission!/1 returns the permission with given id" do
      permission = permission_fixture()
      assert Todo.get_permission!(permission.id) == permission
    end

    test "create_permission/1 with valid data creates a permission" do
      valid_attrs = %{}

      assert {:ok, %Permission{} = permission} = Todo.create_permission(valid_attrs)
    end

    test "create_permission/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_permission(@invalid_attrs)
    end

    test "update_permission/2 with valid data updates the permission" do
      permission = permission_fixture()
      update_attrs = %{}

      assert {:ok, %Permission{} = permission} = Todo.update_permission(permission, update_attrs)
    end

    test "update_permission/2 with invalid data returns error changeset" do
      permission = permission_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_permission(permission, @invalid_attrs)
      assert permission == Todo.get_permission!(permission.id)
    end

    test "delete_permission/1 deletes the permission" do
      permission = permission_fixture()
      assert {:ok, %Permission{}} = Todo.delete_permission(permission)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_permission!(permission.id) end
    end

    test "change_permission/1 returns a permission changeset" do
      permission = permission_fixture()
      assert %Ecto.Changeset{} = Todo.change_permission(permission)
    end
  end
end
