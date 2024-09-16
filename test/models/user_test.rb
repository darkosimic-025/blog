require "test_helper"

class UserTest < ActiveSupport::TestCase
  fixtures :users, :posts

  def setup
    @user = users(:one)
  end

  test "should be valid with valid attributes" do
    assert @user.valid?, "User should be valid with valid attributes"
  end

  test "should be invalid without email" do
    @user.email = nil
    assert_not @user.valid?, "User is valid without an email"
    assert_includes @user.errors[:email], "can't be blank"
  end

  test "should be invalid with duplicate email" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email
    assert_not duplicate_user.valid?, "User is valid with a duplicate email"
    assert_includes duplicate_user.errors[:email], "has already been taken"
  end

  test "should have many posts" do
    assert_equal 1, @user.posts.count, "User should have 1 post"
  end

  test "should destroy associated posts" do
    assert_difference 'Post.count', -@user.posts.count do
      @user.destroy
    end
  end

  test "should authenticate with valid password" do
    assert @user.valid_password?('password'), "User should authenticate with the correct password"
  end

  test "should not authenticate with invalid password" do
    assert_not @user.valid_password?('wrong_password'), "User should not authenticate with an incorrect password"
  end
end
