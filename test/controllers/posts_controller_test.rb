require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get show" do
    get(:show, id: posts(:one).id)
    assert_response :success
  end

  test "should authenticate for edit" do
    get(:edit, {id: posts(:one).id, edit: 'edit'} )
    assert_response 401
  end

  test "should get edit" do
    authenticate("dhh", "secret")
    get(:edit, {id: posts(:one).id, edit: 'edit'} )
    assert_response :success
  end

  test "should authenticate for create" do
    post(:create, {post: {title: 'Some title'}} )
    assert_response 401
  end

  test "should create post" do
    authenticate("dhh", "secret")
    assert_difference('Post.count') do
      post(:create, {post: {title: 'Some title'}} )
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should create post fail" do
    authenticate("dhh", "secret")
    post(:create, {post: {title: 'Som'}} )
    assert_template :new
  end

  test "should authenticate for update" do
    post(:update, {id: posts(:one).id, post: {title: 'aaaaaa', text: 'bbb'}} )
    assert_response 401
  end

  test "should update post" do
    authenticate("dhh", "secret")
    assert_no_difference('Post.count') do
      post(:update, {id: posts(:one).id, post: {title: 'aaaaaa', text: 'bbb'}} )
    end
    assert_redirected_to post_path(assigns(:post))
  end

  test "should update post fail" do
    authenticate("dhh", "secret")
    post(:update, {id: posts(:one).id, post: {title: 'aa', text: 'bbb'}} )
    assert_template :edit
  end

  test "should authenticate for delete" do
    delete :destroy, id: posts(:one).id
    assert_response 401
  end

  test "should delete post" do
    authenticate("dhh", "secret")
    assert_difference 'Post.count', -1 do
      delete :destroy, id: posts(:one).id
    end
    assert_redirected_to :posts
  end
end