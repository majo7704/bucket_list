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

  test 'editing an Idea' do
    idea=Idea.new
    idea.save!
    visit(edit_idea_path(idea))
    fill_in('done_count', with: 73)
    fill_in('title', with: 'Learn Ruby on Rails')
    click_on('Update')
    click_on('Learn Ruby on Rails')

    assert page.has_content?('Learn Ruby on Rails')
    assert page.has_content?('73 have done this')
  end

  test 'search' do
    idea_1=Idea.new
    idea_1.title="Climb Mont Blanc"
    idea_1.save!

    idea_2=Idea.new
    idea_2.title="Visit Niagara Falls"
    idea_2.save!

    visit(root_path)

    fill_in('q', with:'Mont')
    click_on('Search', match: :first)

    assert current_path.include?(ideas_index_path)

    assert page.has_content?('Climb Mont Blanc')

    refute page.has_content?('Visit Niagara Falls')
  end  

  test 'no search results'do
visit(ideas_index_path)
assert page.has_content?('No ideas found!')
end
end
