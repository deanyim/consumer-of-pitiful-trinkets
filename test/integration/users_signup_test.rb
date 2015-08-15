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

  test "Error message testing" do
    empty_password_hash = {
      first_name: "",
      last_name: "",
      email: "daesun@invalid",
      password: "",
      password_confirmation: ""
    }

    empty_password_tests = {
      "user[first_name]" => true,
      "user[last_name]" => true,
      "user[email]" => true,
      "user[password]" => true,
      "user[password_confirmation]" => false,
    }
    post users_path, user: empty_password_hash
    empty_password_tests.each do |field_name, expected|
      assert_select ".field_with_errors [name=?]", field_name, expected
    end

    mismatched_password_hash = empty_password_hash.clone
    mismatched_password_hash[:password] = "lacrosse"
    mismatched_password_tests = empty_password_tests.clone
    mismatched_password_tests["user[password_confirmation]"] = true

    post users_path user: mismatched_password_hash
    mismatched_password_tests.each do |field_name, expected|
      assert_select ".field_with_errors [name=?]", field_name, expected
    end
  end
end
