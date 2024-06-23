require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest


  test  "login with invalid information "  do 
    get  login_path 
    assert_template  'sessions/new' 
    post  login_path ,  params:  {  session:  {  email:  "" ,  password:  ""  }  } 
    assert_response  :unprocessable_entity 
    assert_template  'sessions/new' 
    assert_not  flash.empty? 
    get  root_path 
    assert  flash.empty? 
  end
  
  
  def setup
    @user = users(:michael)  # Load test user
  end

  test "login with valid information" do
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert_redirected_to @user  # Check redirect to user's page
    follow_redirect!  # Actually go to that page
    assert_template 'users/show'  # Verify correct template is shown
    assert_select "a[href=?]", login_path, count: 0  # Ensure "Log in" link is gone
    assert_select "a[href=?]", logout_path  # Check "Log out" link is there
    assert_select "a[href=?]", user_path(@user)  # Ensure profile link is shown
  end


  test "login with valid email/invalid password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email,  password: "invalid" } }
    assert_not is_logged_in?
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_response :see_other
    assert_redirected_to root_url
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
    # login with the valid information test is above where you can make it one by combination. alert
  end

  
end
  
# class LogoutTest < Logout
#   test "should still work after logout in second window" do
#     delete logout_path
#     assert_redirected_to root_url
#   end
# end

   
class RememberingTest < UsersLoginTest
  
    test "login with remembeing" do
      log_in_as(@user, remember_me: '1')
      assert_not cookies[:remember_token].blank?
    end

    # test "login without remembering" do 
    #   log_in_as(@user, remember_me: '1')
    #   log_in_as(@user, remember_me: '0')    # here is the mistake please make sure to fix it and ask the yoya san
    #   assert cookies[:remember_token].blank?
    # end

end