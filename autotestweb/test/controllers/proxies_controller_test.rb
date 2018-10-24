require 'test_helper'

class ProxiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @proxy = proxies(:one)
  end

  test "should get index" do
    get proxies_url
    assert_response :success
  end

  test "should get new" do
    get new_proxy_url
    assert_response :success
  end

  test "should create proxy" do
    assert_difference('Proxy.count') do
      post proxies_url, params: { proxy: { name: @proxy.name, proxytype: @proxy.proxytype, url: @proxy.url } }
    end

    assert_redirected_to proxy_url(Proxy.last)
  end

  test "should show proxy" do
    get proxy_url(@proxy)
    assert_response :success
  end

  test "should get edit" do
    get edit_proxy_url(@proxy)
    assert_response :success
  end

  test "should update proxy" do
    patch proxy_url(@proxy), params: { proxy: { name: @proxy.name, proxytype: @proxy.proxytype, url: @proxy.url } }
    assert_redirected_to proxy_url(@proxy)
  end

  test "should destroy proxy" do
    assert_difference('Proxy.count', -1) do
      delete proxy_url(@proxy)
    end

    assert_redirected_to proxies_url
  end
end
