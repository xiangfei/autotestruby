require "application_system_test_case"

class ConstantsTest < ApplicationSystemTestCase
  setup do
    @constant = constants(:one)
  end

  test "visiting the index" do
    visit constants_url
    assert_selector "h1", text: "Constants"
  end

  test "creating a Constant" do
    visit constants_url
    click_on "New Constant"

    fill_in "Name", with: @constant.name
    fill_in "Scope", with: @constant.scope
    fill_in "Value", with: @constant.value
    click_on "Create Constant"

    assert_text "Constant was successfully created"
    click_on "Back"
  end

  test "updating a Constant" do
    visit constants_url
    click_on "Edit", match: :first

    fill_in "Name", with: @constant.name
    fill_in "Scope", with: @constant.scope
    fill_in "Value", with: @constant.value
    click_on "Update Constant"

    assert_text "Constant was successfully updated"
    click_on "Back"
  end

  test "destroying a Constant" do
    visit constants_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Constant was successfully destroyed"
  end
end
