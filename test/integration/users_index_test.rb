require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users :michael
    @normal_user = users :archer
  end

  test "index as admin including pagination and delete links" do
    log_in_as @admin
    get users_path
    assert_template "users/index"
    assert_select "div.pagination", count: 2
    # first_page_of_users = User.paginate page: 1, per_page: 12
    # first_page_of_users.each do |user|
    #   assert_select "a[href=?]", user, text: user.name
    #   unless user == @admin
    #     assert_select "a[href=?]", user, text: "delete"
    #   end
    # end
    assert_difference "User.count", -1 do
      delete user_path(@normal_user)
    end
  end

  test "index as non-admin" do
    log_in_as @normal_user
    get users_path
    assert_select "a", text: "delete", count: 0
  end
end
