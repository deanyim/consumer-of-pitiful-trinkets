require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(first_name: "Greatest", last_name: "Drake",
                     email: "yimdaesun@gmail.com", password: "asdfasdfasdf",
                     password_confirmation: "asdfasdfasdf")
  end

  test "Newly generated user should be valid" do
    assert @user.valid?
  end

  test "First and last name validation" do
    tests = [
      "  ",
      "a" * 33
    ]

    for name in tests
      @user.first_name = name
      @user.last_name = "Meow"
      assert_not @user.valid?
      @user.first_name = "Meow"
      @user.last_name = name
      assert_not @user.valid?
    end
  end

  test "Email validation" do
    invalid_email_tests = [
      "  ",
      "a" * 246 + "@gmail.com",
      "trick@daddy,com",
      "facebook.com",
      "yimdaesun@gmail..com"
    ]

    for name in invalid_email_tests
      @user.email = name
      assert_not @user.valid?, "#{name} should not be valid"
    end

    valid_email_tests = [
      "yimdaesun@gmail.com",
      "ALL_CAPS@gmail.com",
      "hyphen-dot.address@gmail.com",
      "gmail.com@hotmail.com",
      "yimdaesun+based@gmail.com"
    ]

    for name in valid_email_tests
      @user.email = name
      assert @user.valid?, "#{name} should be valid"
    end
  end

  test "Email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = duplicate_user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "Email addresses should be downcased" do
    obnoxious_email_address = "tUnE-yArDs@4ad.com"
    @user.email = obnoxious_email_address
    @user.save
    assert_equal obnoxious_email_address.downcase, @user.reload.email
  end

  test "Password validation" do
    invalid_password_tests = [
      " " * 10,
      "a" * 9
    ]

    for password in invalid_password_tests
      @user.password = @user.password_confirmation = password
      assert_not @user.valid?, "#{password} should not be valid"
    end
  end
end
