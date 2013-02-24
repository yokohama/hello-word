require 'test_helper'

class MasterWordsControllerTest < ActionController::TestCase
  setup do
    @master_word = master_words(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:master_words)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create master_word" do
    assert_difference('MasterWord.count') do
      post :create, master_word: {  }
    end

    assert_redirected_to master_word_path(assigns(:master_word))
  end

  test "should show master_word" do
    get :show, id: @master_word
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @master_word
    assert_response :success
  end

  test "should update master_word" do
    put :update, id: @master_word, master_word: {  }
    assert_redirected_to master_word_path(assigns(:master_word))
  end

  test "should destroy master_word" do
    assert_difference('MasterWord.count', -1) do
      delete :destroy, id: @master_word
    end

    assert_redirected_to master_words_path
  end
end
