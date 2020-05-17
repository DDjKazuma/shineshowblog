class TagsController < ApplicationController
  
  before_action :require_super
  def new
  
  end
  
  def create
    @tag = Tag.new params.permit(:name,:remark)
    if @tag.save
      flash[:success] = "创建标签成功"
      redirect_to tags_url
    else
      render 'new'
    end
  end
  
  
  def index
    @tags = Tag.all
  end
  
  def edit
    @tag = Tag.find_by_id params[:id]
    if @tag.nil?
      flash[:info] = "无法找到制定的标签"
      redirect_back fallback_location: tags_url
    end
  end
  
  def update
    @tag = Tag.find_by_id params[:id]
    if @tag.nil?
      redirect_back fallback_location: tags_url
    end
    @tag.update tag_params
    flash[:success] = '编辑标签成功'
    redirect_to tags_url
  end
  
  def destroy
    @tag = Tag.find_by_id params[:id]
    if @tag.nil?
      flash[:info] = "无法找到该标签，删除失败"
      redirect_back fallback_location: tags_url
      return
    end
    if @tag.articles.size > 0
      flash[:danger] = "该标签下仍有关联文章，无法删除"
      redirect_back fallback_location: tags_url
      return
    end
    unless @tag.delete
      flash[:success] = "删除成功"
      redirect_back fallback_location: tags_url
      return
    end
    redirect_to tags_url
  end
  
  def tag_params
    params.except('authenticity_token').permit(:name, :mark)
  end
end
