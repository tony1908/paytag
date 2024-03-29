class Company < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :database_authenticatable, :confirmable
  validates :name, presence: true, uniqueness: true
  validates :rfc, length: { maximum: 13 }, uniqueness: true, presence: true
end
