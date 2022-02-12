class CommentsController < ApplicationController

  def create
    tmp_comment = post.comments.new(comment_params)
    if tmp_comment.save
      flash[:success] = 'Commentレコードの作成に成功しました'
    else
      flash[:error] = 'Commentレコードの作成に失敗しました'
    end
    redirect_to post_path(@post)
  end
  
  def edit
    comment
  end

  def update
    if comment.update(comment_params)
      redirect_to post_path(@post), flash: {success: 'Commentレコードの更新に成功しました' }
    else
      flash.now[:error] = 'Commentレコードの更新に失敗しました'
      render :edit
    end
  end

  def destroy
    if comment.destroy
      flash[:success] = 'Commentレコードの削除に成功しました'
    else
      flash[:error] = 'Commentレコードの削除に失敗しました'
    end
    redirect_to post_path(@post)
  end
  
  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def post
    @post ||= Post.find(params[:post_id])
  end

  def comment
    @comment ||= post.comments.find(params[:id])
  end
  helper_method :post, :comment


end
