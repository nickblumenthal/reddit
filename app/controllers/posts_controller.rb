class PostsController < ApplicationController
  before_action :author_only, only: [:edit, :update]

  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      params[:post][:sub_ids].each do |sub_id|
        PostSub.create!(post_id: @post.id, sub_id: sub_id)
      end
      redirect_to post_url(@post.id)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      delete_ids = @post.sub_ids - params[:post][:sub_ids].map(&:to_i)
      add_ids = params[:post][:sub_ids].map(&:to_i) - @post.sub_ids

      delete_ids.each do |delete_id|
        PostSub.destroy_all(sub_id: delete_id)
      end

      add_ids.each do |sub_id|
        PostSub.create!(post_id: @post.id, sub_id: sub_id)
      end
  
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :user_id, :content)
  end

  def author_only
    unless Post.find(params[:id]).user_id == current_user.id
      flash[:errors] = 'Not the author'
      redirect_to subs_url
    end
  end
end
