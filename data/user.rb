# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # include Passpartu
  include Users::TemporaryData
  # include Users::Searchable

  # Include default devise modules. Others available are:
  # :confirmable, :trackable and :omniauthable
  devise :database_authenticatable, :jwt_authenticatable, :invitable, :lockable, :registerable,
         :recoverable, :validatable, :timeoutable, jwt_revocation_strategy: self,
                                                   lock_strategy: :none, unlock_strategy: :none

  validates :first_name, :last_name, presence: true, format: { with: /\A[a-zA-Z]+([ '-][a-zA-Z]+)*\z/,
                                                               message: 'must contain only Latin letters, spaces, apostrophes, or hyphens' }
  validates :phone_number, presence: true, format: { with: /\A\+?\d+\z/, message: "must contain only digits and an optional leading '+'" }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'must be a valid email address' }

  # def role
  #   'admin'
  # end
end
