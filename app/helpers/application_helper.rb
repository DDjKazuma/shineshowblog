module ApplicationHelper
  def is_super?
    !session[:is_super].nil?
  end
  
  def menus
  
  end
  
  def is_logged_in?
    !session[:user_id].nil?
  end
  
  def menu_builder
    if is_super?
      [
        {
          name: "用户管理",
          slug: "userManagement",
          options: [
            {
              name: "用户列表",
              ref: users_url,
              mark: "UL"
            },
            {
              name: "新增用户",
              ref: new_user_url,
              mark: "NU"
            }
          ]
        },
        {
          name: "文章管理",
          slug: "articleManagement",
          options: [
            name: "文章列表",
            ref: articles_url,
            mark: "AL"
          ],
        }
      ]
    else
      # 博主的菜单
      [
        {
          name: "用户管理",
          slug: "userManagement",
          options: [
            {
              name: "用户主页",
              ref: home_index_url,
              mark: "UH"
            },
            {
              name: "修改密码",
              ref: home_edit_password_url,
              mark: "EP"
            }
          ]
        },
        {
          name: "文章管理",
          slug: "articleManagement",
          options: [
            {
              name: "文章列表",
              ref: articles_url,
              mark: "AL"
            },
            {
              name: "新增文章",
              ref: new_article_url,
              mark: "NA"
            }
          ]
        }
      ]
    end
  end
end
