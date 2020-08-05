require "application_system_test_case"

class ShowIdeasTest < ApplicationSystemTestCase
  test "show displays title" do
    idea=Idea.new
    idea.done_count = 13
    idea.title = 'Dance like no one watching'
    idea.save!
  visit(idea_path(idea))
  sleep(10.seconds)
  assert page.has_content?("Dance like no one watching")
  assert page.has_content?('13 people have done this')
  # Assert that the created_at timestamp for the Idea is displayed somewhere on the page.
  assert page.has_content?(idea.created_at.strftime("%d %b '%y"))
  click_on("Edit")
  # Assert that the page matches the URI for the edit_idea route with the Idea that has been created at the start of the test.
  assert_equal current_path, edit_idea_path(idea)
  end
end
