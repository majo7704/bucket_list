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

  test 'most_recent with no ideas' do
    assert_empty Idea.most_recent
  end

  test 'most_recent with two ideas' do
    idea_1=Idea.new
    idea_1.title='Exciting idea 1'
    idea_1.save!
    idea_2=Idea.new
    idea_2.title='Exciting idea 2'
    idea_2.save!

    assert_equal Idea.most_recent.length,2
    assert_equal Idea.most_recent.first, idea_2
  end

  test 'most_recent with six ideas' do
    6.times do |i|
      idea=Idea.new
      idea.title="Exciting idea #{i+1}"
      idea.save!
    end

    assert_equal Idea.most_recent.length,3
    assert_equal Idea.most_recent.first.title, "Exciting idea 6"
  end  
  test 'search with only description match' do
    idea=Idea.new
    idea.title="Surfing in Portugal"
    idea.description="See what Atlantic coast waves are like!"
    idea.save!
    assert_equal 1, Idea.search('coast').length
  end 
  test 'search with description and title' do
    idea_1=Idea.new
    idea_1.title="Overnight hike in Switzerland"
    idea_1.description="Stay in a Swiss refuge in the mountains"
    idea_1.save!

    idea_2=Idea.new
    idea_2.title="Hike the mountains in Italy"
    idea_2.description="See the Dolomites and Italian Alps"
    idea_2.save!

    assert_equal Idea.search('mountains').length,2

  end
end
