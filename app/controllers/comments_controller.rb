class CommentsController < ApplicationController

  def create
    post
    @post.comments.create(comment_params)
    redirect_to post_path(@post)
  end
  
  def edit
    post_comment
  end

  def update
    post_comment
    if @comment.update(comment_params)
      flash[:success] = 'レコードの更新に成功しました'
      redirect_to post_path(@post)
    else
      flash.now[:error] = 'レコードの更新に失敗しました'
      render :'edit'
    end
  end

  def destroy
    post_comment
    @comment.destroy
    redirect_to post_path(@post)
  end

  def post
    @post ||= Post.find(params[:post_id])
  end

  def post_comment
    @post ||= Post.find(params[:post_id])
    @comment ||= @post.comments.find(params[:id])
  end

  helper_method :post, :post_comment
  
  private
  def comment_params
    params.require(:comment).permit(:body)
  end

end
