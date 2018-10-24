require "test_helper"

class TestcasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @testcase = testcases(:one)
  end

  test "should get index" do
    get testcases_url
    assert_response :success
  end

  test "should get new" do
    get new_testcase_url
    assert_response :success
  end

  test "should create testcase" do
    assert_difference("Testcase.count") do
      post testcases_url, params: {testcase: {app_id: @testcase.app_id, case_id: @testcase.case_id, case_name: @testcase.case_name, case_type: @testcase.case_type, folder_name: @testcase.folder_name, is_done: @testcase.is_done}}
    end

    assert_redirected_to testcase_url(Testcase.last)
  end

  test "should show testcase" do
    get testcase_url(@testcase)
    assert_response :success
  end

  test "should get edit" do
    get edit_testcase_url(@testcase)
    assert_response :success
  end

  test "should update testcase" do
    patch testcase_url(@testcase), params: {testcase: {app_id: @testcase.app_id, case_id: @testcase.case_id, case_name: @testcase.case_name, case_type: @testcase.case_type, folder_name: @testcase.folder_name, is_done: @testcase.is_done}}
    assert_redirected_to testcase_url(@testcase)
  end

  test "should destroy testcase" do
    assert_difference("Testcase.count", -1) do
      delete testcase_url(@testcase)
    end

    assert_redirected_to testcases_url
  end
end
