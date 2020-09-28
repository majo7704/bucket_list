require "application_system_test_case"

class SimpleNavigationsTest < ApplicationSystemTestCase
test 'search term is diplayed' do
  visit(root_path)
  assert page.has_content?('Bucket List')
  fill_in('q', match: :first, :with=>'Spain').send_keys(:return)
  assert has_content?('Spain')
  assert current_url.include?('q=Spain')
end

  test "style guide navigation" do
    visit (root_path)
    click_on('Style Guide')
    assert page.has_content?('Atoms')
    assert page.has_content?('Molecules')
    assert page.has_content?('Organisms')
    click_on('Molecules')
    assert page.has_content?('Card')
    click_on('Organisms')
    assert page.has_content?('Create goal')
    click_link('My Bucket List', match: :first)
    assert page.has_content?('Some ideas')
  end
end
