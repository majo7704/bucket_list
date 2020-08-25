require "application_system_test_case"

class IdeasTest < ApplicationSystemTestCase
  test "create new idea" do
    visit(new_idea_path)
    fill_in('Title', with: 'Swim with turtles')
    fill_in('Done count', with: 2)
    fill_in('photo_url', with: 'https://media.farandwide.com/51/8c/518c936514c344f2a218a575f48f7abd.jpg')
    click_on('Create Idea')
    
    assert page.has_content?('Swim with turtles')
  end

  test 'index loads ideas' do
    idea_1 = Idea.new
    idea_1.title = 'Join a tennis club'
    idea_1.save!

    idea_2 = Idea.new
    idea_2.title = 'Join a dance club'
    idea_2.save!

    visit (ideas_path)
    assert page.has_content?('Join a dance club')

    assert page.has_content?('Join a tennis club')
  end

  test 'editing an Idea' do
    idea=Idea.new title: 'Test'
    idea.save!
    visit(edit_idea_path(idea))
    fill_in('Done count', with: 73)
    fill_in('Title', with: 'Learn Ruby on Rails')
    click_on('Update Idea')
    
    
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

    assert current_path.include?(ideas_path)

    assert page.has_content?('Climb Mont Blanc')

    refute page.has_content?('Visit Niagara Falls')
  end  

  test 'no search results'do
    visit(ideas_path)
    assert page.has_content?('No ideas found!')
  end
  test 'test homepage highlights' do
    4.times do |i|
      idea = Idea.new
      idea.title = "Exciting idea #{i+1}"
      idea.save!
    end
    visit(root_path)
    assert page.has_content?('Exciting idea 4')
    assert page.has_content?('Exciting idea 3')
    assert page.has_content?('Exciting idea 2')
    refute page.has_content?('Exciting idea 1')
  end

  test 'search by description and title' do
    idea_1=Idea.new
    idea_1.title='Go cycling across Europe'
    idea_1.description='An amazing way to see lots of Europe'
    idea_1.save!

    idea_2=Idea.new
    idea_2.title='Visit Provance'
    idea_2.description='Go to vineyards, go cycling up Mont Ventoux, see the fields of lavender'
    idea_2.save!

    idea_3=Idea.new
    idea_3.title='Overnight hike in Switzerland'
    idea_3.description='Stay in a Swiss refuge in the mountains'
    idea_3.save!

    visit(root_path)

    fill_in('q', with: 'cycling')

    click_on('Search', match: :first)

    assert page.has_content?('Go cycling across Europe')

    assert page.has_content?('Visit Provance')
    
    refute page.has_content?('Overnight hike in Switzerland')

  end

  
end
