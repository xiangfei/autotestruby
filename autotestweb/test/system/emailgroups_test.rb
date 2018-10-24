require "application_system_test_case"

class EmailgroupsTest < ApplicationSystemTestCase
  setup do
    @emailgroup = emailgroups(:one)
  end

  test "visiting the index" do
    visit emailgroups_url
    assert_selector "h1", text: "Emailgroups"
  end

  test "creating a Emailgroup" do
    visit emailgroups_url
    click_on "New Emailgroup"

    fill_in "Name", with: @emailgroup.name
    click_on "Create Emailgroup"

    assert_text "Emailgroup was successfully created"
    click_on "Back"
  end

  test "updating a Emailgroup" do
    visit emailgroups_url
    click_on "Edit", match: :first

    fill_in "Name", with: @emailgroup.name
    click_on "Update Emailgroup"

    assert_text "Emailgroup was successfully updated"
    click_on "Back"
  end

  test "destroying a Emailgroup" do
    visit emailgroups_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Emailgroup was successfully destroyed"
  end
end
