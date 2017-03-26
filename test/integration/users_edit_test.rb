require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users :michael
  end

  test "unsuccessfull edit" do
    get edit_user_path(@user)
    assert_template "users/edit"
    patch user_path(@user), params: {user: {name: "", email: "foo@invalid",
      password: "123", password_confirmation: "qwerty"}}
    assert_template "users/edit"
    assert_select "div#error_explanation", count: 1
    assert_select "div#error_explanation li", count: 4
  end
end
