require 'test_helper'

class SchemesControllerTest < ActionController::TestCase
  setup do
    @scheme = schemes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:schemes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scheme" do
    assert_difference('Scheme.count') do
      post :create, scheme: { color1: @scheme.color1, color2: @scheme.color2, color3: @scheme.color3, color4: @scheme.color4, color5: @scheme.color5, font1: @scheme.font1, font2: @scheme.font2 }
    end

    assert_redirected_to scheme_path(assigns(:scheme))
  end

  test "should show scheme" do
    get :show, id: @scheme
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scheme
    assert_response :success
  end

  test "should update scheme" do
    patch :update, id: @scheme, scheme: { color1: @scheme.color1, color2: @scheme.color2, color3: @scheme.color3, color4: @scheme.color4, color5: @scheme.color5, font1: @scheme.font1, font2: @scheme.font2 }
    assert_redirected_to scheme_path(assigns(:scheme))
  end

  test "should destroy scheme" do
    assert_difference('Scheme.count', -1) do
      delete :destroy, id: @scheme
    end

    assert_redirected_to schemes_path
  end
end
