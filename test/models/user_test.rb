require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'email is lowercase before validation' do
    user = User.new email: 'nEw@EpFl.Ch', password: 'password'
    user.save!

    assert_equal 'new@epfl.ch', user.email 
  end

end
