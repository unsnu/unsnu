class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :auth_user

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    auth_privilege
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.article.board.anonymous?
      @comment.nickname = current_user.anonymous_nickname
    else
      @comment.nickname = current_user.nickname
    end
    Article.increment_counter(:comment_count, @comment.article)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.article, notice: 'Comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comment }
      else
        format.html { render action: 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    auth_privilege

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment.article, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    auth_privilege

    article = @comment.article
    @comment.destroy
    Article.decrement_counter(:comment_count, @comment.article)
    respond_to do |format|
      format.html { redirect_to article }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :article_id)
    end

    def auth_user
      unless current_user
        redirect_to root_path
      else
        unless current_user.anonymous_available_date == Date.today
          current_user.anonymous_nickname = SecureRandom.hex(4)
          current_user.anonymous_available_date = Date.today
          current_user.save
        end
      end
    end

    def auth_privilege
      unless current_user == @comment.user || current_user.admin?
        redirect_to @comment.article
      end
    end
end
