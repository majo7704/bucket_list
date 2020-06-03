require "application_system_test_case"

class SimpleNavigationsTest < ApplicationSystemTestCase
  # test "search term is displayed" do
  #   visit simple_navigations_url
  
  #   assert_selector "h1", text: "SimpleNavigation"
  # end

  test "style guide navigation" do
    visit ('http://localhost:3000/')
    click_on('Style Guide')
    assert page.has_content?('Atoms')
    assert page.has_content?('Molecules')
    assert page.has_content?('Organisms')
    click_on('Molecules')
    assert page.has_content?('Card')
    click_on('Organisms')
    assert page.has_content?('Create goal')
    click_link('My Bucket List', match: :first)
    sleep(5.seconds)
    assert page.has_content?('Some ideas')
  end
end
