require "test_helper"

class PostTest < ActiveSupport::TestCase
  fixtures :users, :posts

  def setup
    @post = posts(:one)
  end

  test "should be valid with valid attributes" do
    assert @post.valid?, "Post should be valid with valid attributes"
  end

  test "should be invalid without a title" do
    @post.title = nil
    assert_not @post.valid?, "Post is valid without a title"
    assert_includes @post.errors[:title], "can't be blank"
  end

  test "should be invalid without a body" do
    @post.body = nil
    assert_not @post.valid?, "Post is valid without a body"
    assert_includes @post.errors[:body], "can't be blank"
  end

  test "should be valid without an image" do
    assert @post.valid?, "Post should be valid even without an image"
  end

  test "should be able to attach an image" do
    @post.image.attach(io: File.open(Rails.root.join('test', 'fixtures', 'files', 'test.jpg')), filename: 'test.jpg', content_type: 'image/jpg')
    assert @post.image.attached?, "Image should be attached to the post"
  end
end
