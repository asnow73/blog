require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = create :post
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get show" do
    get(:show, id: @post.id)
    assert_response :success
  end

  test "should authenticate for edit" do
    get(:edit, {id: @post.id} )
    assert_response 401
  end

  test "should get edit" do
    authenticate("dhh", "secret")
    get(:edit, {id: @post.id} )
    assert_response :success
  end

  test "should authenticate for create" do
    post(:create, post: @post )
    assert_response 401
  end

  test "should create post" do
    authenticate("dhh", "secret")
    @attr_post = attributes_for :post

    assert_difference('Post.count') do
       post(:create, post: @attr_post )
    end
    assert_redirected_to posts_path
  end

  test "should create post fail" do
    authenticate("dhh", "secret")
    @attr_post = attributes_for(:post, title: "som")
    post(:create, post: @attr_post )
    assert_template :new
  end

  test "should authenticate for update" do
    @attr_post = attributes_for(:post, title: "aaaaaa")
    post(:update, {id: @post.id, post: @attr_post} )
    assert_response 401
  end

  test "should update post" do
    authenticate("dhh", "secret")
    @attr_post = attributes_for(:post, title: "aaaaaa")
    assert_no_difference('Post.count') do
      post(:update, {id: @post.id, post: @attr_post} )
    end
    assert_redirected_to posts_path
  end

  test "should update post fail" do
    authenticate("dhh", "secret")
    @attr_post = attributes_for(:post, title: "aa")
    post(:update, {id: @post.id, post: @attr_post} )
    assert_template :edit
  end

  test "should authenticate for delete" do
    delete :destroy, id: @post.id
    assert_response 401
  end

  test "should delete post" do
    authenticate("dhh", "secret")
    assert_difference 'Post.count', -1 do
      delete :destroy, id: @post.id
    end
    assert_redirected_to :posts
  end
end