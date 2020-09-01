require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'changing associated idea for a Comment' do 
    #create and save new valid Idea
    idea = Idea.new title: 'New idea', user: User.new
    idea.save!

    #create and save a new Comment with "I'd like to do this!" as the `body` value and the Idea
    comment = Comment.new body: "I'd like to do this!", idea: idea, user:User.new
    comment.save!

    #create and save second new Idea with a different title
    idea_2 = Idea.new title: 'Second new idea', user: User.new
    idea_2.save!

    #assign the Idea (idea_2) from step 3 to the `#idea` attribute on the Comment
    comment.idea = idea_2

    #save the comment
    comment.save!

    #assert that `Comment.first.idea` (the Idea associated with the first Comment in the db) is equal to the first comment in the db
    assert_equal idea_2, Comment.first.idea
  end

  test 'cascading save' do
    idea = Idea.new title: 'Relaxing', user: User.new
    idea.save!

    comment = Comment.new body: 'Greate idea', user:User.new
    idea.comments << comment
    idea.save!

    assert_equal comment, Comment.first
  end
  test 'comments are ordered correctly' do
    idea=Idea.new title: 'New Idea', user: User.new
    idea.save!

    comment_1=Comment.new body: 'this would be a great fun', user:User.new
    comment_2=Comment.new body: 'I agree', user:User.new

    #add the first Comment to the `#comments` collection of the Idea
    idea.comments << comment_1
    #add the second Comment to the `#comments` collection of the Idea
    idea.comments << comment_2
    #call `#save!` on the _Idea_ (not the Comment)
    idea.save!
    assert_equal idea.comments.first, comment_1
    assert_equal idea.comments.count, 2

  end
end
