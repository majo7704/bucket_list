require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  test 'changing the title' do
    idea=Idea.new
    idea.title = 'Learn to code'
    idea.save!

    updated_at = idea.updated_at
    idea.title = 'Learn to program in Ruby on Rails'

    assert idea.save
    refute_equal idea.updated_at, updated_at
  end

  test 'setting the title to empty string' do
    idea=Idea.new
    idea.title = 'Learn to code'
    idea.save!

    updated_at = idea.updated_at
    idea.title = ''

    assert idea.save
    refute_equal idea.updated_at, updated_at
  end
end
