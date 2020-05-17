class HomeController < ApplicationController
  def index
    @user = User.find session[:user_id]
    # 显示个人信息
    # 显示文章数量信息
    # 显示浏览信息
    # 用户信息包括，邮箱，手机号，个人简介, 职业
  end
  
  def edit_password
    @user = User.find session[:user_id]
  end
  
  def update_password
    user = User.find(session[:user_id])
    if user.update params.permit(:password, :password_confirmation)
      flash[:success] = "修改密码成功"
      redirect_to home_index_url
    else
      flash[:danger] = "修改密码失败"
      redirect_back fallback_location: home_index_url
    end
  end
  
  
  def update_profile
    @user = User.find(session[:user_id])
    if @user.nil?
      flash[:warning] = "无法找到用户信息"
      redirect_back fallback_location: home_index_url
      return
    end
    if @user.update params.permit(:email, :profession, :avatar, :background, :introduction)
      flash[:success] = "更新用户信息成功"
      redirect_to home_index_url
    else
      redirect_back fallback_location: home_index_url
    end
  end
end
