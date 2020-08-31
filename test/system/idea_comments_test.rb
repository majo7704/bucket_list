require "application_system_test_case"

class IdeaCommentsTest < ApplicationSystemTestCase
test 'adding a Comment to the idea' do
    idea= Idea.new title: 'Swim with sharks'
    idea.save!

    visit idea_path(idea)

    fill_in('Add a comment', with: 'I love your idea')
    click_on('Post', match: :first)
    assert_equal idea_path(idea), page.current_path
    assert page.has_content?('I love your idea')
  end
end
