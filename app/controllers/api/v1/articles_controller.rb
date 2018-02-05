class Api::V1::ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :update, :destroy]
    # GET /articles
  def index
    @articles = Article.order_by(created_at: 'desc').page params[:page]
    #@articles = Article.all
    render json: @articles
  end
  # GET /articles/1
  def show
    render json: @article
  end

  # POST /articles
  def create
    @article = Article.new(article_params)

    if @article.save
      render json: @article, status: :created
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
  end

  def search
    if params[:search].blank?
      @articles = Article.order_by(created_at: 'desc').page params[:page]
    else
      @articles = Article.search(params[:search]).order_by(created_at: 'desc').page params[:page]
    end
    render json: @articles
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def article_params
    params.require(:article).permit(:title, :short_desc, :long_desc, :create_by, :updated_by)
  end
end
