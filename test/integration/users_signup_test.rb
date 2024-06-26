require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "login with valid information" do
    post login_path, params: { session: { email:   @user.email, password: 'password' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end
  
  test  "valid signup information"  do 
    assert_difference  'User.count', 1 do 
    post  users_path,  params: { user: { name: "Example User", email: "user@example.com", password: "password", password_confirmation: "password"}} 
    end
    follow_redirect! 
    assert_template  'users/show'
    assert is_logged_in?   
    end 
  end 

