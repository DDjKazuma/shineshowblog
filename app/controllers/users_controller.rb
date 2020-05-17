class UsersController < ApplicationController
  
  before_action :require_super
  def new
  
  end

  def create
    @user = User.new user_params
    @user.password = "123456" #给用户设置一个初始密码
    if @user.save
      flash[:success] = "创建用户成功"
      redirect_to users_url
    else
      render 'new'
    end
  end
  
  def update
    user = User.find_by_id params[:id]
    if user.nil?
      flash[:info] = "无法找到指定的用户"
      redirect_back fallback_location: users_url
      return
    end
    if user.id == 1
      flash[:info] = "该用户无法被更新"
      redirect_back fallback_location: users_url
      return
    end
    if user.update user_params
      flash[:success] = "更新用户信息成功"
    else
      flash[:danger] = "更新用户信息失败"
    end
    redirect_to users_url
  end
  
  def edit
  
  end
  
  
  def index
    @users = User.all
  end
  
  def destroy
    user = User.find_by_id params[:id]
    if user.nil?
      flash[:info] = '无法找到指定的用户'
      redirect_back fallback_location: users_url
      return
    end
    if user.id == 1
      flash[:info] = "该用户无法被删除"
      redirect_back fallback_location: users_url
      return
    end
    if user.delete
      flash[:success] = "删除用户成功"
    else
      flash[:danger] = "删除用户失败"
    end
    redirect_to users_url
  end
  
  def show
  
  end
  
  def user_params
    params.except('authenticity_token')
      .permit(
        :username,
        # :password,
        :email,
        :profession,
        :avatar,
        :background,
        :introduction
      )
  end
  
  
  def reset_password
    @user = User.find_by_id params[:id]
    if @user.nil?
      flash[:warning] = "无法找到指定的用户，请确认该用户是否存在"
      redirect_back fallback_location: users_url
      return
    end
    @user.password = 123456
    unless user.save
      flash[:danger] = "重设用户密码失败"
      redirect_back fallback_location: users_url
      return
    end
    flash[:sucess] = "重设用户密码成功"
    redirect_to users_url
  end
  
end
