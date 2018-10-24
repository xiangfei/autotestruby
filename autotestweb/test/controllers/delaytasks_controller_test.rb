require 'test_helper'

class DelaytasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @delaytask = delaytasks(:one)
  end

  test "should get index" do
    get delaytasks_url
    assert_response :success
  end

  test "should get new" do
    get new_delaytask_url
    assert_response :success
  end

  test "should create delaytask" do
    assert_difference('Delaytask.count') do
      post delaytasks_url, params: { delaytask: { app: @delaytask.app, apptype: @delaytask.apptype, crontab: @delaytask.crontab } }
    end

    assert_redirected_to delaytask_url(Delaytask.last)
  end

  test "should show delaytask" do
    get delaytask_url(@delaytask)
    assert_response :success
  end

  test "should get edit" do
    get edit_delaytask_url(@delaytask)
    assert_response :success
  end

  test "should update delaytask" do
    patch delaytask_url(@delaytask), params: { delaytask: { app: @delaytask.app, apptype: @delaytask.apptype, crontab: @delaytask.crontab } }
    assert_redirected_to delaytask_url(@delaytask)
  end

  test "should destroy delaytask" do
    assert_difference('Delaytask.count', -1) do
      delete delaytask_url(@delaytask)
    end

    assert_redirected_to delaytasks_url
  end
end
