class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy like dislike]
  before_action :authorize_post, only: %i[edit update destroy like dislike]

  # GET /posts or /posts.json
  def index
    @posts = Post.page(params[:page]).per(10)
  end

  # GET /posts/1 or /posts/1.json
  def show
    authorize! :read, @post
  end

  # GET /posts/new
  def new
    @post = Post.new
    authorize! :create, @post
  end

  # GET /posts/1/edit
  def edit
    # Authorization handled by `authorize_post`
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    authorize! :create, @post

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    # Authorization handled by `authorize_post`
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    # Authorization handled by `authorize_post`
    @post.destroy!
    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # POST /posts/:id/like
  def like
    authorize! :like, @post
    @like = @post.likes.find_or_initialize_by(user: current_user)

    @like.liked = true
    if @like.save
      redirect_to @post, notice: "You liked this post."
    else
      redirect_to @post, alert: "Unable to like this post."
    end
  end

  # POST /posts/:id/dislike
  def dislike
    authorize! :dislike, @post
    @like = @post.likes.find_or_initialize_by(user: current_user)

    @like.liked = false
    if @like.save
      redirect_to @post, notice: "You disliked this post."
    else
      redirect_to @post, alert: "Unable to dislike this post."
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_post
    authorize! action_name.to_sym, @post
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
end
