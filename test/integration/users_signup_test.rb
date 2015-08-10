require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "Invalid signup information -> no User created" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { first_name: "",
                               last_name: "",
                               email: "daesun@invalid",
                               password: "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'users/new'
  end

  test "Valid signup information -> one User created" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {
        first_name: "Daesun",
        last_name: "Yim",
        email: "yimdaesun@gmail.com",
        password: "asdfasdfasdf",
        password_confirmation: "asdfasdfasdf"
      }
    end
    assert_template 'users/show'
  end
end
