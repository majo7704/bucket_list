require "application_system_test_case"

class IdeasTest < ApplicationSystemTestCase
  test "create new idea" do
    visit('ideas/new')
    fill_in('title', with: 'Swim with turtles')
    fill_in('done_count', with: 2)
    fill_in('photo_url', with: 'https://media.farandwide.com/51/8c/518c936514c344f2a218a575f48f7abd.jpg')
    click_on('Create idea')
    
    assert page.has_content?('Swim with turtles')
  end

  test 'index loads ideas' do
    idea_1 = Idea.new
    idea_1.title = 'Join a tennis club'
    idea_1.save!

    idea_2 = Idea.new
    idea_2.title = 'Join a dance club'
    idea_2.save!

    visit ('ideas/index')
    assert page.has_content?('Join a dance club')

    assert page.has_content?('Join a tennis club')

    
  end
end
