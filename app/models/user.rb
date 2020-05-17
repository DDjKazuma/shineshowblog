# require 'bcrypt'
class User < ApplicationRecord
  include BCrypt
  validates_confirmation_of :password
  has_many :articles
  # 用户头像
  has_one_attached :avatar
  # 用户的博客背景
  has_one_attached :background
  # 返回的实际上是进一步处理过的密码
  def password
    @password ||= Password.new(password_hash)
  end
  
  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
