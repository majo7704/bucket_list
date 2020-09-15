require 'test_helper'

class RolesHelperTest < ActionView::TestCase
  attr_accessor :current_user

  test 'idea can be edited by owner' do
    owner = User.create(email: 'owner@example.com', password: 'password')
    self.current_user = owner
    idea= Idea.create(title: 'TestIdea', user: owner)
    assert can_edit?(idea)
  end

  test 'idea can be edited by admin' do
    admin = User.create(email: 'admin@example.com', password: 'password', role: 'admin')
    self.current_user = admin

    owner = User.create(email: 'owner@example.com', password: 'password')
    idea= Idea.create(title: 'TestIdea', user: owner)
    
    assert can_edit?(idea)
  end

  test 'idea cannot be edited by other user' do
    other = User.create(email: 'other@example.com', password: 'password')
    self.current_user = other

    owner = User.create(email: 'owner@example.com', password: 'password')
    idea= Idea.create(title: 'TestIdea', user: owner)

    refute can_edit?(idea)

  
  end
end
