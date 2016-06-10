require 'test_helper'

class QuizzesControllerTest < ActionController::TestCase

  def setup
    @quiz = quizzes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get show" do
    get :show, id: @quiz
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @quiz
    assert_response :success
  end

  test "should get update" do
    patch :update, id: @quiz, quiz: { title: @quiz.title, description: @quiz.description }
    assert_redirected_to @quiz
  end

end
