require "application_system_test_case"

class LogInsTest < ApplicationSystemTestCase
  test 'signup create user' do
    visit(new_user_path)
    fill_in('Email', with: 'new@epfl.ch')
    fill_in('Password', with: 'password')
    click_button('Sign up', match: :first)
    assert_equal 1, User.all.length
    assert_equal 'new@epfl.ch', User.first.email
  end

  test 'log in does not create a User' do
    user = User.new email: 'existing@epfl.ch', password: 'password'
    visit(new_user_path)
    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)

    click_button('Sign up')
    assert_equal 1, User.all.length
    
  end

end
