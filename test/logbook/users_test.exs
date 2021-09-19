defmodule Logbook.UsersTest do
  use Logbook.DataCase, async: true
  doctest Logbook.Users

  alias Logbook.Users
  alias Logbook.UsersTestHelpers, as: Helpers

  setup do
    user = Helpers.create_user!()

    {
      :ok,
      user: user
    }
  end

  test "creating a new user creates the user", %{user: user} do
    assert Repo.exists?(from u in Users.User, where: u.id == ^user.id)
  end

  test "user first_name required" do
    {success, _user} = Helpers.create_user(%{first_name: nil})
    assert success == :error
  end

  test "user last_name required" do
    {success, _user} = Helpers.create_user(%{last_name: nil})
    assert success == :error
  end

  test "user email required" do
    {success, _user} = Helpers.create_user(%{email: nil})
    assert success == :error
  end

  test "user update first_name updates", %{user: user} do
    Helpers.update_user(user, %{first_name: "Anothername"})
    %Users.User{first_name: first_name} = Repo.get(Users.User, user.id)
    assert first_name == "Anothername"
  end

  test "user update last_name updates", %{user: user} do
    Helpers.update_user(user, %{last_name: "Anothername"})
    %Users.User{last_name: last_name} = Repo.get(Users.User, user.id)
    assert last_name == "Anothername"
  end

  test "user update email updates", %{user: user} do
    Helpers.update_user(user, %{email: "another@gmail.com"})
    %Users.User{email: email} = Repo.get(Users.User, user.id)
    assert email == "another@gmail.com"
  end
end
