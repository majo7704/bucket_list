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

  test 'updated_at is changed after updating title'do
    idea=Idea.new
    idea.title='Visit Marakesh'
    idea.save!
    first_updated_at = idea.updated_at
    idea.title = 'Visit the market in Marakesh'
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating photo_url'do
idea=Idea.new
    idea.photo_url='/images/turtle.jpg'
    idea.save!
    first_updated_at = idea.updated_at
    idea.photo_url = '/images/turtle-big.jpg'
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
end

  test 'one matching result' do
    idea=Idea.new
    idea.title ='Stand at the top of the Empire State Building'
    idea.save!

    assert_equal Idea.search('the top').length, 1
  end

  test 'no matching result' do
    idea=Idea.new
    idea.title ='Stand at the top of the Empire State Building'
    idea.save!

    assert_empty Idea.search('snorkelling')
  end

  test 'two matching result' do
    idea=Idea.new
    idea.title ='Stand at the top of the Empire State Building'
    idea.save!

    idea_1=Idea.new
    idea_1.title ='Stand on the pyramids'
    idea_1.save!

    assert_equal Idea.search('Stand').length, 2
  end
end
