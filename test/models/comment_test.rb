require "test_helper"

class CommentTest < ActiveSupport::TestCase
  fixtures :users, :posts, :comments

  def setup
    @comment = comments(:one)
  end

  test "should be valid with valid attributes" do
    assert @comment.valid?, "Comment should be valid with valid attributes"
  end

  test "should be invalid without a body" do
    @comment.body = nil
    assert_not @comment.valid?, "Comment is valid without a body"
    assert_includes @comment.errors[:body], "can't be blank"
  end

  test "should belong to a user and post" do
    assert_equal users(:one), @comment.user, "Comment should belong to the correct user"
    assert_equal posts(:one), @comment.post, "Comment should belong to the correct post"
  end

  test "should destroy comment when associated post is destroyed" do
    post = posts(:one)
    assert_difference('Comment.count', -post.comments.count) do
      post.destroy
    end
  end

  test "should destroy comment when associated user is destroyed" do
    user = users(:one)
    assert_difference('Comment.count', -user.comments.count) do
      user.destroy
    end
  end
end
