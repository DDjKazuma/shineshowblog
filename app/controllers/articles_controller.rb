class ArticlesController < ApplicationController
  def index
    if helpers.is_super?
      @articles = Article.all
    else
      @articles = Article.where("user_id = ?", session[:user_id])
    end
  end
  
  def new
  end
  
  def create
    @article = Article.new article_params.slice(:title,:content,:picture)
    @article.user_id = session[:user_id]
    @article.tag_ids = article_params[:tag_ids]
    if @article.save
      redirect_to articles_url
    else
      flash[:success] = "创建文章失败"
      render 'new'
    end
  end
  
  def show
    @article = Article.find params[:id]
    if @article.nil?
      flash[:info] = "无法找到文章"
    end
    if @article.user_id != session[:user_id] && !helpers.is_super?
      redirect_back fallback_location: articles_url
    end
  end
  
  def article_params
    params.except('authenticity_token').permit(:title,:content,:picture,:tag_ids=>[])
  end
  
  def destroy
    article = Article.find params[:id]
    if !helpers.is_super? && article.user_id != session[:user_id]
        session[:waring] = "您无权删除该文章"
        redirect_back fallback_location: articles_url
    end
    if Article.delete(params[:id])
      flash[:info] = "删除失败"
      redirect_back fallback_location: articles_url
    else
      redirect_to articles_url
    end
    
  end
  
  def edit
    @article = Article.find_by_id params[:id]
    if @article.user_id != session[:user_id] && !helpers.is_super?
      # 如果既不是作者也不是超级管理员，则不给编辑
        session[:waring] = "您无权编辑"
        redirect_back fallback_location: articles_url
    end
  end
  
  def update
    @article = Article.find params[:id]
    if !helpers.is_super? && @article.user_id != session[:user_id]
        session[:waring] = "您无权编辑"
        redirect_back fallback_location: articles_url
    end
    @article.update article_params
    flash[:success] = "编辑文章成功"
    redirect_to articles_url
  end
  
end
