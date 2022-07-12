class User < ApplicationRecord
    validates :email, presence: true
    validates :password, presence: true
    has_many :posts, :dependent => :destroy
end
