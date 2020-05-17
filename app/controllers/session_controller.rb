class SessionController < ApplicationController
  layout false
  
  skip_before_action :require_login
  def show_login
  end
  
  # 登陆操作，成功后跳转到主页
  def login
    @user = User.find_by_username params[:username]
    if @user.nil? then logger.info "can't find user with name #{params[:username]}"; end
    if @user.nil? || @user.password != params[:password]
      flash[:info] = "用户不存在或用户密码不正确"
      render 'show_login'
      return
    end
    session[:user_id] = @user.id
    session[:is_super] = true if @user.id == 1
    redirect_to articles_url
  end

  # 退出登陆
  def logout
    session.destroy
    redirect_to session_show_login_url
  end
  
end
