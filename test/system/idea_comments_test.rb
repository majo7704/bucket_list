require "application_system_test_case"

class IdeaCommentsTest < ApplicationSystemTestCase
test 'adding a Comment to the idea' do
    user = User.new email: 'user@example.com'
    user.save!

    idea= Idea.new title: 'Swim with sharks', user: User.new
    idea.save!

    visit(new_user_path)
    fill_in('Email', with: user.email)
    click_on('Log in')

    visit idea_path(idea)

    fill_in('Add a comment', with: 'I love your idea')
    click_on('Post', match: :first)
    assert_equal idea_path(idea), page.current_path
    assert page.has_content?('I love your idea')
  end

  test 'comments cannot be added when not logged in' do
    idea= Idea.new title: 'Swim with sharks', user: User.new
    idea.save!

    visit idea_path(idea)
    refute page.has_content?('Add a comment')

  end
end
