require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  test 'changing the title' do
    idea=Idea.new title: 'Learn to code', user: User.new
    idea.save!

    updated_at = idea.updated_at
    idea.title = 'Learn to program in Ruby on Rails'

    assert idea.save
    refute_equal idea.updated_at, updated_at
  end

  test 'setting the title to empty string' do
    idea=Idea.new title: 'Learn to code', user: User.new
    idea.save!

    updated_at = idea.updated_at
    idea.title = 'Learn to swim'

    assert idea.save
    refute_equal idea.updated_at, updated_at
  end

  test 'updated_at is changed after updating title'do
    idea=Idea.new title: 'Visit Marakesh', user: User.new
    idea.save!
    first_updated_at = idea.updated_at
    idea.title = 'Visit the market in Marakesh'
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating photo_url'do
    idea=Idea.new title: 'Visit Marakesh', 
                  photo_url: '/images/turtle.jpg', user:User.new
    idea.save!
    first_updated_at = idea.updated_at
    idea.photo_url = '/images/turtle-big.jpg'
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'one matching result' do
    idea=Idea.new title: 'Stand at the top of the Empire State Building', user: User.new
    idea.save!

    assert_equal Idea.search('the top').length, 1
  end

  test 'no matching result' do
    idea=Idea.new title: 'Stand at the top of the Empire State Building', user: User.new
    idea.save!

    assert_empty Idea.search('snorkelling')
  end

  test 'two matching result' do
    idea=Idea.new title: 'Stand at the top of the Empire State Building', user: User.new
    idea.save!

    idea_1=Idea.new title: 'Stand on the pyramids',
                    user: User.new
    idea_1.save!

    assert_equal Idea.search('Stand').length, 2
  end

  test 'most_recent with no ideas' do
    assert_empty Idea.most_recent
  end

  test 'most_recent with two ideas' do
    idea_1=Idea.new title: 'Exciting idea 1', user: User.new
    idea_1.save!
    idea_2=Idea.new title: 'Exciting idea 2', user: User.new
    idea_2.save!

    assert_equal Idea.most_recent.length,2
    assert_equal Idea.most_recent.first, idea_2
  end

  test 'most_recent with six ideas' do
    6.times do |i|
      idea=Idea.new user: User.new
      idea.title="Exciting idea #{i+1}"
      idea.save!
    end

    assert_equal Idea.most_recent.length,3
    assert_equal Idea.most_recent.first.title, "Exciting idea 6"
  end  
  test 'search with only description match' do
    idea=Idea.new title: "Surfing in Portugal", 
                  description:"See what Atlantic coast waves are like!", 
                  user: User.new
    idea.save!
    assert_equal 1, Idea.search('coast').length
  end 
  test 'search with description and title' do
    idea_1=Idea.new title: "Overnight hike in Switzerland", 
                    description: "Stay in a Swiss refuge in the mountains", 
                    user: User.new
    idea_1.save!

    idea_2=Idea.new title: "Hike the mountains in Italy", 
                    description: "See the Dolomites and Italian Alps", 
                    user: User.new
    idea_2.save!

    assert_equal Idea.search('mountains').length,2

  end

  test 'maximum length of title' do
    idea =Idea.new title: 'very long title very long title very long title very long title very long title very long title very long title very long title', user: User.new

    #idea is not going to be valid
    refute idea.valid?
  end

  test 'presence of title' do
    idea=Idea.new user: User.new
    
    #show that idea is not valid when it does not have a title
    refute idea.valid?
  end

  test 'the first empty Idea created is first in the list' do
    first_idea=Idea.new title: 'First idea', 
                        user: User.new
    first_idea.save!
    second_idea=Idea.new title: 'Second idea', 
                          user: User.new
    second_idea.save!
    assert_equal(first_idea, Idea.all.first)
  end  

  test 'the first idea created is first on the list' do
    first_idea=Idea.new title: 'First idea',
                        done_count: 3, 
                        user: User.new
    first_idea.save!
    second_idea=Idea.new title: 'Second idea',
                        done_count: 3, 
                        user: User.new 
    second_idea.save!
    assert(first_idea, Idea.all.first)                   
  end  
  
end
