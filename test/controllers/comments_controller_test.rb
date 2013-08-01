require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  setup do
    @post = create :post
    @comment = create :comment
  end

  test "should create comment" do
    @attr_comment = attributes_for :comment
    assert_difference('Comment.count') do
      post :create, post_id: @post.id, comment: @attr_comment
    end
    assert_redirected_to post_path(assigns(:post))
  end

  test "should authenticate for delete comment" do
    delete(:destroy, {post_id: @post.id, id: @comment.id} )
    assert_response 401
  end

  test "should delete comment" do
    authenticate("dhh", "secret")
    @post.comments << @comment
    assert_difference '@post.comments.count', -1 do
      delete(:destroy, {post_id: @post.id, id: @comment.id} )
    end
    assert_redirected_to post_path(assigns(:post))
  end

end