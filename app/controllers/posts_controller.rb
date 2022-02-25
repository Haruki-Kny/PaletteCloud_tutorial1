class PostsController < ApplicationController

  def index
    @posts = Post.all.order(created_at: 'desc')
  end

  def show
    @comment = post.comments.new
  end

  def new
    @post = Post.new
  end

  def create
    # render plain: params[:post].inspect
    # save
    @post = Post.new(post_params)
    if @post.save
      # redirect
      redirect_to posts_path, flash: {success: 'Postレコードの保存に成功しました'}
    else
      flash.now[:error] = 'Postレコードの保存に失敗しました'
      render :new
    end
  end

  def edit
    post
  end

  def update
    if post.update(post_params)
      redirect_to posts_path, flash: {success: 'Postレコードの更新に成功しました' }
    else
      flash.now[:error] = 'Postレコードの更新に失敗しました'
      render :edit
    end
  end
  
  def destroy
    if post.destroy
      flash[:success] = 'Postレコードの削除に成功しました'
    else
      flash[:error] = 'Postレコードの削除に失敗しました'
    end      
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def post
    @post ||= Post.find(params[:id])
  end  
  helper_method :post

end
