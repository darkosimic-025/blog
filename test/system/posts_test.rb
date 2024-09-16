require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "user cannot submit an empty form" do
    visit new_user_session_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: 'password'
    click_on "Log in"

    assert_text @user.email

    visit new_post_path

    assert_current_path new_post_path

    find('input[type="submit"][value="Create Post"]').click

    assert_selector "div", text: "Title can't be blank"
    assert_selector "div", text: "Body can't be blank"
  end

end
