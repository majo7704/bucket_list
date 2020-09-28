require "application_system_test_case"

class IdeaCommentsTest < ApplicationSystemTestCase
test 'adding a Comment to the idea' do
    user = User.new email: 'user@example.com', password: 'password'
    user.save!

    idea= Idea.new title: 'Swim with sharks', user: user
    idea.save!

    visit(new_session_path)
    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    click_on('Log in', match: :first)

    visit idea_path(idea)

    fill_in('comment_body', with: 'I love your idea')
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
