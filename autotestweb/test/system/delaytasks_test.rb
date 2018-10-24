require "application_system_test_case"

class DelaytasksTest < ApplicationSystemTestCase
  setup do
    @delaytask = delaytasks(:one)
  end

  test "visiting the index" do
    visit delaytasks_url
    assert_selector "h1", text: "Delaytasks"
  end

  test "creating a Delaytask" do
    visit delaytasks_url
    click_on "New Delaytask"

    fill_in "App", with: @delaytask.app
    fill_in "Apptype", with: @delaytask.apptype
    fill_in "Crontab", with: @delaytask.crontab
    click_on "Create Delaytask"

    assert_text "Delaytask was successfully created"
    click_on "Back"
  end

  test "updating a Delaytask" do
    visit delaytasks_url
    click_on "Edit", match: :first

    fill_in "App", with: @delaytask.app
    fill_in "Apptype", with: @delaytask.apptype
    fill_in "Crontab", with: @delaytask.crontab
    click_on "Update Delaytask"

    assert_text "Delaytask was successfully updated"
    click_on "Back"
  end

  test "destroying a Delaytask" do
    visit delaytasks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Delaytask was successfully destroyed"
  end
end
