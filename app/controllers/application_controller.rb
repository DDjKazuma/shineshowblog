class ApplicationController < ActionController::Base
  layout "main"

  before_action :require_login
  
  private
  
  def require_login
    if session[:user_id].nil?
      flash[:warning] = "您尚未登陆"
      redirect_to session_show_login_url
    end
  end
  
  def require_super
    # 判断是否是超级管理员
    unless helpers.is_super?
      flash[:warning] = "你不是超级管理员"
      redirect_back fallback_location: articles_url
    end
  end
  
end
