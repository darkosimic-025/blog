require "test_helper"

class LikeTest < ActiveSupport::TestCase
  fixtures :users, :posts, :likes

  def setup
    @like = likes(:one)
  end

  test "should be valid with valid attributes" do
    assert @like.valid?, "Like should be valid with valid attributes"
  end

  test "should be invalid without a user" do
    @like.user = nil
    assert_not @like.valid?, "Like is valid without a user"
    assert_includes @like.errors[:user], "must exist"
  end

  test "should be invalid without a post" do
    @like.post = nil
    assert_not @like.valid?, "Like is valid without a post"
    assert_includes @like.errors[:post], "must exist"
  end

  test "should belong to a user and post" do
    assert_equal users(:one), @like.user, "Like should belong to a user"
    assert_equal posts(:one), @like.post, "Like should belong to a post"
  end

  test "should destroy all likes when associated user is destroyed" do
    user = users(:one)
    assert_difference('Like.count', -user.likes.count) do
      user.destroy
    end
  end


  test "should destroy all likes when associated post is destroyed" do
    post = posts(:one)
    assert_difference('Like.count', -post.likes.count) do
      post.destroy
    end
  end
end
