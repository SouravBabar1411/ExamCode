# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :integer          default("admin")
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github]

  #Enum for assigning roles
  enum role: [:admin, :user]

  def self.from_omniauth(access_token)
    user = User.where(email: access_token.info.email).first
    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(first_name: access_token.info.name,
        email: access_token.info.email,
        password: Devise.friendly_token[0,20]
      )
    end
    user.email = access_token.info.email
    user.first_name = access_token.info.name
    user.image = access_token.info.image
    user.uid = access_token.uid
    user.provider = access_token.provider
    user.save
    user
  end
end
