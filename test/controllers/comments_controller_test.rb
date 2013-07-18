require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  test "should create comment" do
    assert_difference('posts(:one).comments.count') do
      post(:create, {post_id: posts(:one).id, comment: {commenter: 'David', body: 'Comments text'}} )
    end
    assert_redirected_to post_path(posts(:one))
  end

  test "should authenticate for delete comment" do
    delete(:destroy, {post_id: posts(:one).id, id: comments(:one).id} )
    assert_response 401
  end

  test "should delete comment" do
    authenticate("dhh", "secret")
    posts(:one).comments << comments(:one)
    assert_difference 'posts(:one).comments.count', -1 do
      delete(:destroy, {post_id: posts(:one).id, id: comments(:one).id} )
    end
    assert_redirected_to post_path(posts(:one))
  end

end