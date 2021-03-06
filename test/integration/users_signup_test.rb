require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_select "form[action='/signup']"
    assert_no_difference "User.count" do
      post signup_path, params: {user: {name: "", email: "user@invalid",
        password: "foo", password_confirmation: "bar"}}
    end
    assert_template "users/new"
    assert_select "div#error_explanation"
    assert_select "div.field_with_errors", count: 8
  end

  test "valid signup information" do
    get signup_path
    assert_select "form[action='/signup']"
    assert_difference "User.count", 1 do
      post signup_path, params: {user: {name: "ahihi", email: "ahihi@demo.com",
        password: "123qwe", password_confirmation: "123qwe"}}
    end
    follow_redirect!
    assert_template "users/show"
    assert flash.present?
    assert_select "div.alert-success"
    assert is_logged_in?
  end
end
