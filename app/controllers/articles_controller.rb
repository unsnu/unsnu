class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :auth_user

  # GET /articles
  # GET /articles.json
  def index
    @board = Board.find(params[:board_id])
    @articles = @board.articles.page params[:page]
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Board.find(params[:board_id]).articles.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.board.anonymous?
      @article.nickname = current_user.anonymous_nickname
    else
      @article.nickname = current_user.nickname
    end

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render action: 'show', status: :created, location: @article }
      else
        format.html { render action: 'new' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :nickname, :content, :upvote, :downvote, :comment_count, :locked, :view_count, :board_id)
    end

    def auth_user
      unless current_user
        redirect_to root_path
      end

      unless current_user.anonymous_available_date == Date.today
        current_user.anonymous_nickname = SecureRandom.hex(4)
        current_user.anonymous_available_date = Date.today
        current_user.save
      end
    end
end
