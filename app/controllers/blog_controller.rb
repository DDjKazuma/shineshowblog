class BlogController < FrontApplicationController

  # 单篇博客详情
  def show
    @blog = Article.find_by_id! params[:id]
    @other_blogs = Article.where("id != ?", params[:id]).limit(3)
  end
  
  # 博客列表
  def index
    @blogs = Article.where("user_id = ?", params[:user_id])
    @user = User.find params[:user_id]
  end
  
  # 作者详情
  def author
    @author = User.find_by_id! params[:id]
  end
  
end
