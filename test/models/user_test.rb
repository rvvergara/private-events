require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # 1. Presence of all valid attributes
  # name, username, email, password
  def setup
    @user = User.new(name: 'John', username: 'john01', email: 'john@demo.com', password: 'password', password_confirmation: 'password')
  end

  test 'name should be present' do
    @user.name = ""
    assert_not @user.valid?
  end

end
