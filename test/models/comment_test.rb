require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'changing associated idea for a Comment' do 
    #create and save new valid Idea
    idea = Idea.new title: 'New idea'
    idea.save!

    #create and save a new Comment with "I'd like to do this!" as the `body` value and the Idea
    comment = Comment.new body: "I'd like to do this!", idea: idea
    comment.save!

    #create and save second new Idea with a different title
    idea_2 = Idea.new title: 'Second new idea'
    idea_2.save!

    #assign the Idea (idea_2) from step 3 to the `#idea` attribute on the Comment
    comment.idea = idea_2

    #save the comment
    comment.save!

    #assert that `Comment.first.idea` (the Idea associated with the first Comment in the db) is equal to the first comment in the db
    assert_equal idea_2, Comment.first.idea


  end
end
