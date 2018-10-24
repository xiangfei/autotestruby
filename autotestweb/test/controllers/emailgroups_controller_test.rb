require 'test_helper'

class EmailgroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @emailgroup = emailgroups(:one)
  end

  test "should get index" do
    get emailgroups_url
    assert_response :success
  end

  test "should get new" do
    get new_emailgroup_url
    assert_response :success
  end

  test "should create emailgroup" do
    assert_difference('Emailgroup.count') do
      post emailgroups_url, params: { emailgroup: { name: @emailgroup.name } }
    end

    assert_redirected_to emailgroup_url(Emailgroup.last)
  end

  test "should show emailgroup" do
    get emailgroup_url(@emailgroup)
    assert_response :success
  end

  test "should get edit" do
    get edit_emailgroup_url(@emailgroup)
    assert_response :success
  end

  test "should update emailgroup" do
    patch emailgroup_url(@emailgroup), params: { emailgroup: { name: @emailgroup.name } }
    assert_redirected_to emailgroup_url(@emailgroup)
  end

  test "should destroy emailgroup" do
    assert_difference('Emailgroup.count', -1) do
      delete emailgroup_url(@emailgroup)
    end

    assert_redirected_to emailgroups_url
  end
end
