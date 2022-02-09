class PostsController < ApplicationController

  def index
    @posts = Post.all.order(created_at: 'desc')
  end

  def show
    post
    @comment = @post.comments.new
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
      flash[:success] = 'レコードの保存に成功しました'
      redirect_to posts_path
    else
      flash.now[:error] = 'レコードの保存に失敗しました'
      render :'new'
    end
  end

  def edit
    post
  end

  def update
    post
    if @post.update(post_params)
      flash[:success] = 'レコードの更新に成功しました'
      redirect_to posts_path
    else
      flash.now[:error] = 'レコードの更新に失敗しました'
      render :'edit'
    end
  end
  
  def destroy
    post
    @post.destroy
    redirect_to posts_path
  end

  def post
    @post ||= Post.find(params[:id])
  end
  
  helper_method :post

  private
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
