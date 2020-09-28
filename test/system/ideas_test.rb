require "application_system_test_case"

class IdeasTest < ApplicationSystemTestCase
  test "create new idea" do
    user = User.new email: 'new@example.com', password: 'password'
    user.save!
    visit(new_session_path)
    fill_in('Email', with: 'new@example.com')
    fill_in('Password', with: 'password')
    click_button('Log in')
    visit(new_idea_path)
    fill_in('Title', with: 'Swim with turtles')
    fill_in('Done count', with: 2)
    fill_in('photo_url', with: 'https://media.farandwide.com/51/8c/518c936514c344f2a218a575f48f7abd.jpg')
    click_on('commit')
    
    
    assert page.has_content?('Swim with turtles')
  end

  test 'index loads ideas' do
    idea_1 = Idea.new title: 'Join a tennis club',
                      user: User.new
    idea_1.save!

    idea_2 = Idea.new title: 'Join a dance club',
                        user: User.new
    idea_2.save!

    visit (ideas_path)
    assert page.has_content?('Join a dance club')

    assert page.has_content?('Join a tennis club')
  end

  test 'editing an Idea' do
    user = User.new email: 'user@example.ch', password: 'password'
    idea=Idea.new title: 'Test', user: user
    idea.save!
    visit(edit_idea_path(idea))
    fill_in('Done count', with: 73)
    fill_in('Title', with: 'Learn Ruby on Rails')
    click_on('Update Idea')
    
    
    assert page.has_content?('Learn Ruby on Rails')
    assert page.has_content?('73 have done this')
  end

  test 'search' do
    idea_1=Idea.new user: User.new
    idea_1.title="Climb Mont Blanc"
    idea_1.save!

    idea_2=Idea.new  user: User.new
    idea_2.title="Visit Niagara Falls"
    idea_2.save!

    visit(root_path)

    fill_in('q', match: :first, with:'Mont')
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
      idea = Idea.new  user: User.new
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
    idea_1=Idea.new title: 'Go cycling across Europe',
                    description: 'An amazing way to see lots of Europe',
                    user: User.new
    idea_1.save!

    idea_2=Idea.new title: 'Visit Provance', description: 'Go to vineyards, go cycling up Mont Ventoux, see the fields of lavender', user: User.new
    idea_2.save!

    idea_3=Idea.new title: 'Overnight hike in Switzerland', description: 'Stay in a Swiss refuge in the mountains', user: User.new
    idea_3.save!

    visit(root_path)

    fill_in('q', with: 'cycling')

    click_on('Search', match: :first)

    assert page.has_content?('Go cycling across Europe')

    assert page.has_content?('Visit Provance')
    
    refute page.has_content?('Overnight hike in Switzerland')

  end

  test 'new idea with no title' do
    user=User.new email: 'new@example.com', password: 'password'
    user.save!
    visit(new_session_path)
    fill_in('Email', with: 'new@example.com')
    fill_in('Password', with: 'password')
    click_button('Log in')
    visit(new_idea_path())
    click_on('Create Idea')
    assert page.has_content?("Title can't be blank")
  end

  test 'existing idea updated with no title' do
    idea= Idea.new title: 'New Title', user: User.new
    idea.save!
    visit(edit_idea_path(idea))
    fill_in('Title', with: '')
    click_on('Update Idea')
    assert page.has_content?("Title can't be blank")
  end
  

end
