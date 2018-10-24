require "application_system_test_case"

class TestcasesTest < ApplicationSystemTestCase
  setup do
    @testcase = testcases(:one)
  end

  test "visiting the index" do
    visit testcases_url
    assert_selector "h1", text: "Testcases"
  end

  test "creating a Testcase" do
    visit testcases_url
    click_on "New Testcase"

    fill_in "App", with: @testcase.app_id
    fill_in "Case", with: @testcase.case_id
    fill_in "Case Name", with: @testcase.case_name
    fill_in "Case Type", with: @testcase.case_type
    fill_in "Folder Name", with: @testcase.folder_name
    fill_in "Is Done", with: @testcase.is_done
    click_on "Create Testcase"

    assert_text "Testcase was successfully created"
    click_on "Back"
  end

  test "updating a Testcase" do
    visit testcases_url
    click_on "Edit", match: :first

    fill_in "App", with: @testcase.app_id
    fill_in "Case", with: @testcase.case_id
    fill_in "Case Name", with: @testcase.case_name
    fill_in "Case Type", with: @testcase.case_type
    fill_in "Folder Name", with: @testcase.folder_name
    fill_in "Is Done", with: @testcase.is_done
    click_on "Update Testcase"

    assert_text "Testcase was successfully updated"
    click_on "Back"
  end

  test "destroying a Testcase" do
    visit testcases_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Testcase was successfully destroyed"
  end
end
