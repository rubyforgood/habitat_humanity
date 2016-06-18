class User < ActiveRecord::Base
  include RoleModel

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Never re-order this list
  roles :admin, :site_supervisor
end
