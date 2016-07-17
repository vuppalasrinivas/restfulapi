class Api::V1::PostsController < ApplicationController
  #http_basic_authenticate_with :name => "myfinance", :password => "credit123"
  before_filter :restrict_access
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  respond_to :json
  # GET /posts
  def index
   respond_with @posts = Post.all
  end

  # GET /posts/1
  def show

  end

  # GET /posts/new
  def new
     respond_with @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      respond_with @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:name, :message)
    end

    def restrict_access
        api_key = ApiKey.find_by_access_token(params[:access_token])
        head :unauthorized unless api_key
      end
end
